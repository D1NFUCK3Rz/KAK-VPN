if [[ -e /usr/bin/ipsm ]]; then
IP=$(cat /usr/bin/ipsm);
fi
if [[ "$IP" = "" ]]; then
    IP=$(hostname -I | sed -n '1p' | awk '{print $1}')
fi

figlet -f ASCII-Shadow.flf KUY - VPN | lolcat
echo -e "\e[35m     Server IP $IP " | lolcat
