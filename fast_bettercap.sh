#!/bin/bash

### BEGIN INIT INFO
# Provides:          anonsurf
# Required-Start:
# Required-Stop:
# Should-Start:
# Default-Start:
# Default-Stop:
# Short-Description: Transparent Proxy through TOR.
### END INIT INFO
#
# Devs:
# Lorenzo 'Palinuro' Faletra <palinuro@parrotsec.org>
# Lisetta 'Sheireen' Ferrero <sheireen@autistiche.org>
# Francesco 'Mibofra' Bonanno <mibofra@parrotsec.org>
#
# Extended:
# Daniel 'Sawyer' Garcia <dagaba13@gmail.com>
#
# anonsurf is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
# You can get a copy of the license at www.gnu.org/licenses
#
# anonsurf is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Parrot Security OS. If not, see <http://www.gnu.org/licenses/>.







export BLUE='\033[1;94m'
export GREEN='\033[1;92m'
export RED='\033[1;91m'
export RESETCOLOR='\033[1;00m'


# Destinations you don't want routed through Tor
TOR_EXCLUDE="192.168.0.0/16 172.16.0.0/12 10.0.0.0/8"

# The UID Tor runs as
# change it if, starting tor, the command 'ps -e | grep tor' returns a different UID
TOR_UID="debian-tor"

# Tor's TransPort
TOR_PORT="9040"









function notify {
	if [ -e /usr/bin/notify-send ]; then
		/usr/bin/notify-send "AnonSurf" "$1"
	fi
}
export notify


function init {
	echo -e -n "$BLUE[$GREEN*$BLUE] $RED Matando aplicaciones peligrosas.\n"
	sudo killall -q chrome dropbox iceweasel skype icedove thunderbird firefox firefox-esr chromium xchat hexchat transmission steam firejail
	echo -e -n "$BLUE[$GREEN*$BLUE] $GREEN Aplicaciones peligrosas matadas..\n"
	notify "Aplicaciones peligrosas matadas"

	echo -e -n "$BLUE[$GREEN*$BLUE] $RED Limpieza de algunos elementos de caché peligrosos.\n"
	bleachbit -c adobe_reader.cache chromium.cache chromium.current_session chromium.history elinks.history emesene.cache epiphany.cache firefox.url_history flash.cache flash.cookies google_chrome.cache google_chrome.history  links2.history opera.cache opera.search_history opera.url_history &> /dev/null
	echo -e -n "$BLUE[$GREEN*$BLUE] $GREEN Cache Limpiada..\n"
	notify "Cache limpiada"
}


function ip {

	MYIP=`wget -qO- https://start.parrotsec.org/ip/`
	echo -e "\nMi ip es:\n"
	echo $MYIP
	echo -e "\n"
	notify "Mi IP es:\n\n$MYIP"
}


function start {
	clear
	# Make sure only root can run this script
	ME=$(whoami | tr [:lower:] [:upper:])
	if [ $(id -u) -ne 0 ]; then
		echo -e -e "\n$GREEN[$RED!$GREEN] $RED $ME R U DRUNK?? This script must be run as root$RESETCOLOR\n" >&2
		exit 1
	fi

	echo -e "\n$BLUE[$GREEN i$BLUE ]$GREEN Iniciando el modo anónimo:$RESETCOLOR\n"

	if [ ! -e /tmp/tor.pid ]; then
		echo -e " $GREEN*$RED Tor no está corriendo! $GREEN Iniciando tor para ti.." >&2
		echo -e -n "\n $GREEN*$RED Deteniendo el servicio nscd"
		service nscd stop 2>/dev/null || sleep 0.3 ;echo " (Detenido)"
		echo -e -n "\n $GREEN*$RED Deteniendo el servicio resolvconf"
		service resolvconf stop 2>/dev/null || sleep 0.3 ;echo " (Detenido)"
		echo -e -n "\n $GREEN*$RED Deteniendo el servicio dnsmasq"
		service dnsmasq stop 2>/dev/null || sleep 0.3 ;echo " (Detenido)"
		killall dnsmasq nscd resolvconf 2>/dev/null || true
		sleep 2
		killall -9 dnsmasq 2>/dev/null || true
		systemctl start tor
		sleep 3
	fi


	if ! [ -f /etc/network/iptables.rules ]; then
		iptables-save > /etc/network/iptables.rules
		echo -e "\n $BLUE*$GREEN Reglas de iptables guardadas\n"
	fi

	iptables -F
	iptables -t nat -F

	mv /etc/resolv.conf /etc/resolv.conf.bak
	echo -e 'nameserver 127.0.0.1\nnameserver 139.99.96.146\nnameserver 37.59.40.15\nnameserver 185.121.177.177' > /etc/resolv.conf
	echo -e " $BLUE*$GREEN Se modificó resolv.conf para usar Tor y ParrotDNS / OpenNIC\n"

	# disable ipv6
	echo -e " $BLUE*$RED Deshabilitando IPv6 por razones de seguridad\n"
	sysctl -w net.ipv6.conf.all.disable_ipv6=1
	sysctl -w net.ipv6.conf.default.disable_ipv6=1

	# set iptables nat
	echo;echo -e " $BLUE*$GREEN Configurando las reglas de iptables para enrutar todo el tráfico a través de tor\n"
	iptables -t nat -A OUTPUT -m owner --uid-owner $TOR_UID -j RETURN

	#set dns redirect
	echo -e " $BLUE*$GREEN Redireccionando el tráfico DNS a través de tor\n"
	iptables -t nat -A OUTPUT -p udp --dport 53 -j REDIRECT --to-ports 53
	iptables -t nat -A OUTPUT -p tcp --dport 53 -j REDIRECT --to-ports 53
	iptables -t nat -A OUTPUT -p udp -m owner --uid-owner $TOR_UID -m udp --dport 53 -j REDIRECT --to-ports 53

	#resolve .onion domains mapping 10.192.0.0/10 address space
	iptables -t nat -A OUTPUT -p tcp -d 10.192.0.0/10 -j REDIRECT --to-ports $TOR_PORT
	iptables -t nat -A OUTPUT -p udp -d 10.192.0.0/10 -j REDIRECT --to-ports $TOR_PORT

	#exclude local addresses
	for NET in $TOR_EXCLUDE 127.0.0.0/9 127.128.0.0/10; do
		iptables -t nat -A OUTPUT -d $NET -j RETURN
		iptables -A OUTPUT -d "$NET" -j ACCEPT
	done

	#redirect all other output through TOR
	iptables -t nat -A OUTPUT -p tcp --syn -j REDIRECT --to-ports $TOR_PORT
	iptables -t nat -A OUTPUT -p udp -j REDIRECT --to-ports $TOR_PORT
	iptables -t nat -A OUTPUT -p icmp -j REDIRECT --to-ports $TOR_PORT

	#accept already established connections
	iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

	#allow only tor output
	echo -e " $BLUE*$GREEN Permitiendo solo navegar en red clara\n"
	iptables -A OUTPUT -m owner --uid-owner $TOR_UID -j ACCEPT
	iptables -A OUTPUT -j REJECT

	echo -e "$BLUE *$GREEN Todo el tráfico fue redirigido a través de Tor.\n"
	echo -e "$BLUE[$GREEN i$BLUE ]$GREEN Estás bajo el túnel de AnonSurf.$RESETCOLOR\n"
	notify "Proxy anónimo global activado"
	sleep 1
	notify "Baila como si nadie estuviese mirando :)"
	sleep 1
}


function stop {
	# Make sure only root can run our script
	ME=$(whoami | tr [:lower:] [:upper:])

	if [ $(id -u) -ne 0 ]; then
		echo -e "\n$GREEN[$RED!$GREEN] $RED $ME R U DRUNK?? This script must be run as root$RESETCOLOR\n" >&2
		exit 1
	fi

	echo -e "\n$BLUE[$RED i$BLUE ]$RED Deteniendo el modo anónimo:$RESETCOLOR\n"

	iptables -F
	iptables -t nat -F
	echo -e "\n $BLUE*$RED Eliminado todas las reglas de iptables"

	if [ -f /etc/network/iptables.rules ]; then
		iptables-restore < /etc/network/iptables.rules
		rm /etc/network/iptables.rules
		echo -e "\n $BLUE*$GREEN Reglas de iptables restauradas "
	fi
	echo -e -n "\n $BLUE*$GREEN Restaurar el servicio de DNS";echo;
	if [ -e /etc/resolv.conf.bak ]; then
		rm /etc/resolv.conf
		mv /etc/resolv.conf.bak /etc/resolv.conf
	fi

	# re-enable ipv6
	echo ;
	sysctl -w net.ipv6.conf.all.disable_ipv6=0
	sysctl -w net.ipv6.conf.default.disable_ipv6=0
	echo;

	service tor stop
	sleep 2
	killall tor 2> /dev/null
	sleep 2
	echo -e -n "$BLUE *$GREEN Reiniciando servicios..\n"
	service resolvconf start || service resolvconf restart || true
	service dnsmasq start 2> /dev/null
	service nscd start 2> /dev/null
	echo -e " $BLUE*$GREEN No preocuparse por los errores de inicio de dnsmasq y nscd si aún no están instalados o iniciados."
	sleep 1

	echo -e " $BLUE*$GREEN Modo anónimo detenido\n"
	notify "Proxy Anónimo Global Cerrado - Deja de bailar :("
	sleep 2
}


function change {
	exitnode-selector
	sleep 5
	echo -e " $BLUE*$GREEN Tor daemon recargado y forzado a cambiar nodos.\n"
	notify "Identidad cambiada, bailemos de nuevo.!"
	sleep 1
}


function status {
	service tor@default status
	cat /tmp/anonsurf-tor.log || cat /var/log/tor/log
}



case "$1" in
	start)
		zenity --question --text="¿Quieres que anonsurf mate aplicaciones peligrosas y limpie algunos cachés de aplicaciones??" && init
		start
	;;
	stop)
		zenity --question --text="¿Quieres que anonsurf mate aplicaciones peligrosas y limpie algunos cachés de aplicaciones??" && init
		stop
	;;
	changeid|change-id|change)
		change
	;;
	status)
		status
	;;
	myip|ip)
		ip
	;;
	mac|mymac)
		mac
	;;
	restart)
		$0 stop
		sleep 1
		$0 start
	;;
   *)
echo -e "
Parrot AnonSurf Module (v 2.8.1)
	Developed by Lorenzo \"Palinuro\" Faletra <palinuro@parrotsec.org>
		     Lisetta \"Sheireen\" Ferrero <sheireen@parrotsec.org>
		     Francesco \"Mibofra\" Bonanno <mibofra@parrotsec.org>
		and a huge amount of Caffeine + some GNU/GPL v3 stuff
	Extended by Daniel \"Sawyer\" Garcia <dagaba13@gmail.com>

	Usage:
	$RED┌──[$GREEN$USER$YELLOW@$BLUE`hostname`$RED]─[$GREEN$PWD$RED]
	$RED└──╼ \$$GREEN"" anonsurf $RED{$GREEN""start$RED|$GREEN""stop$RED|$GREEN""restart$RED|$GREEN""change$RED""$RED|$GREEN""status$RED""}

	$RED start$BLUE -$GREEN Iniciar el túnel de TOR en todo el sistema
	$RED stop$BLUE -$GREEN Detener el anonsurf y volver a clearnet.
	$RED restart$BLUE -$GREEN Combina la opcion \"stop\" y \"start\" 
	$RED changeid$BLUE -$GREEN Reinicie TOR para cambiar la identidad
	$RED status$BLUE -$GREEN Compruebe si AnonSurf está funcionando correctamente
	$RED myip$BLUE -$GREEN Comprueba tu ip y verifica tu conexión tor
	$RED mymac$BLUE -$GREEN Revisa tu mac y verifica tu cambio de dirección mac
$RESETCOLOR
Baila como si nadie estuviese mirando..
" >&2
exit 1

	;;
esac

echo -e $RESETCOLOR
exit 0
