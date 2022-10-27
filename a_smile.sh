#!/bin/bash
rm install a_smile
# download script
apt-get update
apt-get upgrade
apt-get install figlet -y
apt-get install ruby -y
gem install lolcat
wget -O /usr/share/figlet/ASCII-Shadow.flf https://raw.githubusercontent.com/D1NFUCK3Rz/KAK-VPN/main/ASCII-Shadow.flf

if [ -e /usr/bin/chekmenu ]; then
echo > ok
rm ok
else
echo > /usr/bin/chekmenu
chmod +x /usr/bin/chekmenu
fi
echo " ❯❯❯ OK ดิ้นรอเลยครับ"
cd /usr/local/bin
wget -O .smile-vpn "https://raw.githubusercontent.com/D1NFUCK3Rz/KAK-VPN/main/menu.sh"
wget -O m "https://raw.githubusercontent.com/D1NFUCK3Rz/KAK-VPN/main/m"
wget -O menu "https://raw.githubusercontent.com/D1NFUCK3Rz/KAK-VPN/main/menu"
wget -O speedtest "https://github.com/D1NFUCK3Rz/KAK-VPN/raw/main/speedtest"
wget -O b-user "https://raw.githubusercontent.com/D1NFUCK3Rz/KAK-VPN/main/b-user"
chmod +x speedtest
chmod +x b-user
chmod +x m
chmod +x menu
chmod +x .smile-vpn
smile=$2
smilee=$1
if [ -d /usr/bin/cr ]; then
echo
else 
cd /usr/bin
wget -q -O cr "https://raw.githubusercontent.com/D1NFUCK3Rz/KAK-VPN/main/cr.sh"
chmod +x cr
fi

if [[  ! -e /dev/net/tun ]] ; then
    echo "❯❯❯ TUN/TAP device is not available."
fi
cd
if [[ -e /etc/debian_version ]]; then
VERSION_ID=$(cat /etc/os-release | grep "VERSION_ID")
fi
if [[ -e /etc/yum ]]; then
VERSION_ID=$(cat /etc/os-release | grep "VERSION_ID")
fi

if [[ $smile == "" ]]
then
clear
cr
echo "    ╭━━━━━━━━━━━━━━━━━━━╮" | lolcat
echo "    ┣ เลือกระบบที่จะติดตั้ง Scrip      " | lolcat
echo "    ╰━━━┳━━━━━━━━━━━┳━━━╯" | lolcat
echo "    ╭━━━┻━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━╮" | lolcat
echo "    ┃ ใส่ตัวเลขแล้วกด enter" | lolcat
echo "    ┣━━━━━━━━━━━━━━━━━╯" | lolcat
echo "    ┣ 1. OpenVPN        " | lolcat
echo "    ┣ 2. L2TP Debian8 & Ubuntu14.4     " | lolcat
echo "    ┣ 3. WebPanel Debian8 & Ubuntu14.4       " | lolcat
echo "    ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯" | lolcat
read -p "    ╰━━ Number : " opcao
else
opcao=$smile
fi
case $opcao in
 1 | 01 )
 if [[ "$smile" = "" ]]; then
clear
else
clear
cr
echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ แน่ใจคุณต้องการรันระบบ OpenVPN    
        ┣━━━━━━━━━━━━━━━━━━━━━━━╯   "
    read -p "        ╰━━ ( Y/n ) : " Confirn
    if [[ "$Confirn" = "y" || "$Confirn" = "Y" ]]; then
    clear
    else
wget -q -O a_smile "https://raw.githubusercontent.com/D1NFUCK3Rz/KAK-VPN/main/a_smile.sh"
exit 0
    fi
fi

  cd
wget -q -O install "https://raw.githubusercontent.com/D1NFUCK3Rz/KAK-VPN/main/s_openvpn"
bash install
exit
;;
 2 | 02 )
 if [[ "$smile" = "" ]]; then
clear
else
clear
cr
echo "        ╭━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ แน่ใจคุณต้องการติดตั้ง L2tp    
        ┣━━━━━━━━━━━━━━━━━━━━━╯ "
    read -p "        ╰━━ ( Y/n ) : " Confirn
    if [[ "$Confirn" = "y" || "$Confirn" = "Y" ]]; then
    clear
    else
wget -q -O a_smile "https://raw.githubusercontent.com/D1NFUCK3Rz/KAK-VPN/main/a_smile.sh"
bash a_smile
exit 0
    fi
fi

wget -q -O install "https://raw.githubusercontent.com/D1NFUCK3Rz/KAK-VPN/raw/main/l2tp.sh"
bash install
exit 0
if [[ "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
clear
else
clear
cr
echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ L2TP สามารถติดตั้งได้แค่ OS Debian8 Ubuntu14.4
        ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯
 "
exit 0
fi

;;
3 )
if [[ "$smile" = "" ]]; then
clear
else
clear
cr
echo "        ╭━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ แน่ใจคุณต้องการติดตั้ง Panel    
        ┣━━━━━━━━━━━━━━━━━━━━━╯    "
    read -p "        ╰━━ ( Y/n ) : " Confirn
    if [[ "$Confirn" = "y" || "$Confirn" = "Y" ]]; then
    clear
    else
wget -q -O a_smile "https://raw.githubusercontent.com/D1NFUCK3Rz/KAK-VPN/main/a_smile.sh"
bash a_smile
exit 0
    fi
fi

wget -q -O panel "https://raw.githubusercontent.com/D1NFUCK3Rz/KAK-VPN/raw/main/panel.sh"
bash panel
exit 0
if [[ "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
clear
else
clear
cr
echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ Panel สามารถติดตั้งได้แค่ OS Debian8 Ubuntu14.4
        ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯
 "
exit 0
fi
;;
$opcao )
clear
cr
echo "        ╭━━━━━━━━━━━━━━━━━━━╮ 
        ┣ โปรดพิมพ์คำสั่งให้ถูกต้อง
        ╰━━━━━━━━━━━━━━━━━━━╯
 "
exit 0
;;
 esac
 



