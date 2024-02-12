#!/bin/bash


function disclaimer (){
tput civis
clear

echo -e "\e[31m# Este script usa nmap para escanear puertos a una dirección IP"
echo -e "# Nmap es una herramienta de código abierto que se usa para analizar redes y realizar auditorías de seguridad"
echo -e "# El uso de nmap puede estar sujeto a restricciones legales o éticas, dependiendo de la intención, el consentimiento y el daño potencial que se cause a terceros"
echo -e "# El autor de este script no se hace responsable de las consecuencias derivadas del uso indebido o ilegal de nmap o de este script"
echo -e "# El usuario debe usar este script bajo su propia responsabilidad y con el permiso explícito del dueño de la red o del sistema que se escanea"
echo -e "# Este script se distribuye bajo la licencia GNU General Public License v3.0, que se puede consultar en https://www.gnu.org/licenses/gpl-3.0.html \e[0m"
sleep 3
clear
tput cnorm
SCANS
}


# Función Ctrl+C

function ctrl_c (){
tput civis
clear
        echo -e "\e[31m\n\n[!] Saliendo...\n\n"
        sleep 1.5
        tput cnorm; exit 1
}


# Ctrl+C

trap ctrl_c INT



# Comprobar root

function areuroot (){
tput civis
clear

  if ! [ $(id -u) = 0 ]; then

        echo -e "\e[31mAre u root?"

        exit 1
  else
        echo "\e[32mU are root"
        tput cnorm
        disclaimer
  fi
}



# Comprobar carpeta SCANS


function SCANS (){
tput civis
clear
echo -e "\e[35m----------------------------------"
echo -e "- Comprobando carpeta SCANS...    "
echo -e "----------------------------------\e[0m"
sleep 2
clear

        if [ -d SCANS/ ]; then

        echo -e "\e[32m-----------------------------"
        echo -e "- ¡Carpeta SCANS existe!         "
        echo -e "-----------------------------\e[0m"
        sleep 1.5
        tput cnorm
        Bienvenida
else

        echo -e "\e[31m-----------------------------"
        echo -e "- Carpeta SCANS no existe"
        echo -e "-----------------------------\e[0m"
        mkdir SCANS
        chmod o+rwx SCANS/
        echo -e "\e[32m----------------------------------"
        echo -e "\e[32m- Carpeta SCANS creada...    "
        echo -e "----------------------------------\e[0m"
        sleep 1.5
        tput cnorm
        Bienvenida
        fi
}


# Bienvenida

function Bienvenida (){
        tput civis

        if [ -e SCANS/user.txt ]; then

clear
        echo -e "\e[31mBienvenido $(cat SCANS/user.txt)\e[0m"
        sleep 2
        tput cnorm
        start
else
        tput civis
        clear
        read -p "¿Cual es tu nombre?: " name
        sleep 1.5
        clear
        echo "$name" > SCANS/user.txt
        Bienvenida
        tput cnorm
        fi
}



# Start Program

function start (){
tput civis
clear
echo -e "\e[32m---------------------------------------------"
read -p " Introduce la IP: " target
echo -e "---------------------------------------------------"
echo -e " El escaneo será guardado en SCANS/$target"
echo -e "---------------------------------------------------\e[0m"
sleep 2
clear

echo -e "\e[31m-----------------"
echo -e "- Escaneando...    "
echo -e "------------------\e[0m"
echo
echo -e "\e[31m---------------------------------------------------------------------------------------------------------------\n\e[32m"

nmap -p- --open -sSV -vvv -n $target -oN "SCANS/$target.log" | grep -w "PORT" -A 9999 | grep -w "Read data files" -B 9999


echo -e "\n\e[31m---------------------------------------------------------------------------------------------------------------\e[0m"
tput cnorm
}

areuroot
