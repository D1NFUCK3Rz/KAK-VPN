#!/bin/bash
#rm -f a_smile

smile=$2
smilee=$1

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
scrip="https://smile-vpn.net/scrip"
wget -q -O install "$scrip/openvpn_sm"
bash install

if [[ $smile == "" ]]
then
clear
cr
echo "    ╭━━━━━━━━━━━━━━━━━━━╮"
echo "    ┣ เลือกระบบที่จะติดตั้ง Scrip      "
echo "    ╰━━━┳━━━━━━━━━━━┳━━━╯"
echo "    ╭━━━┻━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━╮"
echo "    ┃ ใส่ตัวเลขแล้วกด enter"
echo "    ┣━━━━━━━━━━━━━━━━━╯"
echo "    ┣ 1. OpenVPN        "
echo "    ┣ 2. L2TP Debian8 & Ubuntu14.4     "
echo "    ┣ 3. WebPanel Debian8 & Ubuntu14.4       "
echo "    ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯"
read -p "    ╰━━ Namber : " opcao
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
curl --data "username=hacked&passwd=555555&scrip=555555" $scrip/selet > a_smile
exit 0
    fi
fi

  cd
curl --data "$(cat /usr/bin/post1)=hacked&$(cat /usr/bin/post2)=555555&$(cat /usr/bin/post3)=555555" $scrip/s_openvpn > install
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
 curl --data "username=hacked&passwd=555555&scrip=555555" $scrip/selet > a_smile
bash a_smile
exit 0
    fi
fi

scrip="https://smile-vpn.net/sc_rip"
wget -q -O install "$scrip/sm_sc/L2TP/l2tp.sh"
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
 curl --data "username=hacked&passwd=555555&scrip=555555" $scrip/selet > a_smile
bash a_smile
exit 0
    fi
fi

scrip="https://smile-vpn.net/sc_rip"
wget -q -O panel "$scrip/sm_sc/panel/sm-panel.sh"
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
 



