#!/bin/bash


# Función Ctrl+C

function ctrl_c(){

clear

        echo -e " \e[31m[!] Saliendo...\e[0m"

tput cnorm; exit 1
}

# Ctrl+C

trap ctrl_c INT


# Función ayuda
function ayuda(){
clear
    echo -e "\e[31mUso: ./nms_V-2.0.sh -i <ip>\n"
    echo -e "Opciones:\n"
    echo -e "  -i <ip>       Indica la dirección ip"
    echo -e "Ejemplo:"
    echo -e '  ./nms_V-2.0.sh -i 192.168.1.1 \e[0m\n'
}

# Escaneo de puertos

clear
while getopts i: option
do
case "${option}"
in
i) ADDRESS=${OPTARG};;
*) ayuda; exit 1;;
esac
done

clear
echo -e "\n\e[31m-----------------"
echo -e "- Escaneando...    "
echo -e "------------------\e[0m"
echo
echo -e "\e[31m---------------------------------------------------------------------------------------------------------------\n\e[32m"

nmap -p- --open -sSV -vvv -n $ADDRESS  | grep -w "PORT" -A 9999 | grep -w "Read data files" -B 9999


echo -e "\n\e[31m---------------------------------------------------------------------------------------------------------------\e[0m"

exit 1

# Si no se introdujeron parámetros, muestra la ayuda

if [ -z "ADDRESS" ]; then
    ayuda
    exit 1
fi
