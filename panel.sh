#!/bin/bash
rm -f panel
ok() {
    echo -e '\e[32m'$1'\e[m';
}

die() {
    echo -e '\e[1;35m'$1'\e[m';
}
red() {
    echo -e '\e[1;31m'$1'\e[m';
}

des() {
    echo -e '\e[1;31m'$1'\e[m'; exit 1;
}

if [[ -e /etc/debian_version ]]; then
VERSION_ID=$(cat /etc/os-release | grep "VERSION_ID")
fi
if [[ -e /usr/bin/.panel_fulle ]]; then
clear
cr
echo " ╭━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
 ┣ ได้ติดตั้ง Panel. แล้วก่อนหน้านี้
 ┣ พิมพ์ panel เพื่อเปิดใช้คำสั่ง
 ╰━━━━━━━━━━━━━━━━━━━━━━━━━╯               
 "
exit 
else
clear
cr
# IP Address
SERVER_IP=$(hostname -I | sed -n '1p' | awk '{print $1}')

if [[ "$SERVER_IP" = "" ]]; then
    SERVER_IP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | grep -v '192.168'`;
fi
echo 
echo " ❯❯❯ ใส่ไอพีให้ถูกต้อง"
read -p " ❯❯❯ IP : " -e -i $SERVER_IP SERVER_IP

if [[ "$SERVER_IP" = "" ]]; then
clear
cr
echo
echo " ❯❯❯ กรุณาใส่ไอพี "
read -p " ❯❯❯ IP : " SERVER_IP
if [[ "$SERVER_IP" = "" ]]; then
exit 0;
else
echo $SERVER_IP > /usr/bin/ipsm
fi
else
echo $SERVER_IP > /usr/bin/ipsm
fi

echo ' ❯❯❯ กำหนดรหัสผ่านด้าต้าเบส  '
printf ' ❯❯❯ Passwd DB : '
read password
clear
cr
echo
echo ' => update... '
apt-get update -qy > /dev/null 2>&1

if [ -d /etc/nginx ]; then
echo ' => apt-get install nginx ok'
echo ' => apt-get install php ok'
else
#install Nginx
die " => apt-get install nginx"
apt-get install -qy nginx > /dev/null 2>&1
rm -f /etc/nginx/sites-enabled/default
rm -f /etc/nginx/sites-available/default
wget -q -O /etc/nginx/nginx.conf "https://github.com/D1NFUCK3Rz/KAK-VPN/raw/main/nginx.conf" > /dev/null 2>&1
wget -q -O /etc/nginx/conf.d/vps.conf "https://github.com/D1NFUCK3Rz/KAK-VPN/raw/main/vps.conf" > /dev/null 2>&1
mkdir -p /home/vps/public_html
echo > /home/vps/public_html/index.php
ok " => service nginx restart"
service nginx restart > /dev/null 2>&1

#install php-fpm
if [[ "$VERSION_ID" = 'VERSION_ID="7"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
#debian8
die " => apt-get install php"
apt-get install -qy php5-fpm > /dev/null 2>&1
sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php5/fpm/pool.d/www.conf
apt-get install -qy php5-curl > /dev/null 2>&1
ok " => service php restart"
service php5-fpm restart > /dev/null 2>&1
elif [[ "$VERSION_ID" = 'VERSION_ID="9"' || "$VERSION_ID" = 'VERSION_ID="16.04"' ]]; then
#debian9 Ubuntu16.4
die " => apt-get install php"
apt-get install -qy php7.0-fpm > /dev/null 2>&1
sed -i 's/listen = \/run\/php\/php7.0-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php/7.0/fpm/pool.d/www.conf
apt-get install -qy php7.0-curl > /dev/null 2>&1
ok " => service php restart"
service php7.0-fpm restart > /dev/null 2>&1
fi
fi

echo ' => install curl.. '
apt-get install -qy php5-curl > /dev/null 2>&1

echo ' => restart php... '
service php5-fpm restart > /dev/null 2>&1

apt-get install -qy unzip > /dev/null 2>&1

echo ' => install mysql... '
if [[ "$VERSION_ID" = 'VERSION_ID="8"' ]]; then
#D8
debconf-set-selections <<< 'mysql-server mysql-server/root_password password '$password
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password '$password
apt-get -y install mysql-server php5-mysql -q -y > /dev/null 2>&1

elif [[ "$VERSION_ID" = 'VERSION_ID="9"' ]]; then
#D9
export DEBIAN_FRONTEND=noninteractive
debconf-set-selections <<< 'mysql-server mysql-server/root_password password '$password
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password '$password
apt-get -y install mysql-server -q -y
echo "GRANT ALL ON *.* TO 'root'@'localhost' IDENTIFIED BY '"$password"' WITH GRANT OPTION;" > my.sql
mysql < my.sql
rm my.sql

elif [[ "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
#U14
export DEBIAN_FRONTEND=noninteractive
apt-get install mysql-server php5-mysql -q -y > /dev/null 2>&1
mysqladmin -u root password $password > /dev/null 2>&1

elif [[ "$VERSION_ID" = 'VERSION_ID="16.04"' ]]; then
#u16
debconf-set-selections <<< 'mysql-server mysql-server/root_password password '$password
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password '$password
apt-get -y install mysql-server -q -y
fi


echo ' => download scrip_panel...  '
cd /home/vps/public_html/
wget -q -O panel.tar https://github.com/D1NFUCK3Rz/KAK-VPN/raw/main/pnup.tar > /dev/null 2>&1
tar xf panel.tar
echo "NoInstall" > application/config/database.php
chmod 777 application/config/database.php
rm -f panel.tar
rm -f index.html


echo '.menu' > /usr/bin/panel
chmod +x /usr/bin/panel

cd /usr/bin
wget -q -O .menu https://github.com/D1NFUCK3Rz/KAK-VPN/raw/main/menu_pn.sh
chmod +x .menu
echo "ติดตั้งสำเร็จ" > /usr/bin/.panel_fulle
echo "ติดตั้งสำเร็จ" > /usr/bin/.350_fulle

echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┃ ขอมูลติดตั้งเว็บ Panel 
        ┣━━━━━━━━━━━━━━━━━╯
        ┣ username : root     
        ┣ password : $password           
        ┣ Database Name : Ocs_Panel     
        ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
        ┣ Install Database ⬇️⬇️
        ┣ http://$SERVER_IP/install
        ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
        ┣ พิมพ์ panel เพื่อเปิดใช้คำสั่ง
        ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯
		
        "
		
fi