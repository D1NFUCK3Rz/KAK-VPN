#!/bin/bash
IP=$(cat /usr/bin/ipsm)
if [ -e /usr/bin/.350_fulle ]; then
clear
cr
echo "    ╭━━━━━━━━━━━━━━━━━━━╮"
echo "    ┣  จัดการ Panel      "
echo "    ╰━━━┳━━━━━━━━━━━┳━━━╯"
echo "    ╭━━━┻━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━╮"
echo "    ┃ ใส่ตัวเลขแล้วกด enter"
echo "    ┣━━━━━━━━━━━━━━━━━╯"
echo "    ┣ 1. แบ็คอับ Database       "
echo "    ┣ 2. รีสโตร์ Database       "
echo "    ┣ 3. เพิ่มไฟล์ OpenVPN ลงในเว็บ       "
echo "    ┣ 4. ตั้งค่า % AutoWallet       "
echo "    ┣ 5. ติดตั้ง PhpMyadmin       "
echo "    ┣ 6. อัปเดตเว็บไซต์       "
echo "    ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯"
read -p "    ╰━━ Namber : " opcao
case $opcao in
1)
clear
cr
echo "    ╭━━━━━━━━━━━━━━━━━━━╮"
echo "    ┣ แบ็คอับข้อมูลเว็บไซต์       "
echo "    ┣━━━━━━━━━━━━━━━━━━━╯"
read -p "    ┣ ชื่อตาราง DB เซิฟนี้ ➡️  : " namedb
read -p "    ╰ หัสผ่าน My_admin ➡️  : " passwd

cd
clear
cr
mysqldump -u root -p$passwd $namedb > database.sql
tar cf /home/vps/public_html/db.tar database.sql
rm -f database.sql
echo "    ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮"
echo "    ┣ สถานะ ถ้าไม่มีเอ่อเร่อแสดงว่าผ่านเรียบร้อย "
echo "    ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯"

exit
;;
2 )
clear
cr
echo "    ╭━━━━━━━━━━━━━━━━━━━╮"
echo "    ┣ คืนค่าข้อมูลเว็บไซต์จากอีกไอพี      "
echo "    ┣━━━━━━━━━━━━━━━━━━━╯"
read -p "    ┣ ไอพีเว็บที่แบ็คอับ DB  ➡️ : " dns2
read -p "    ┣ ยืนยันการคืนค่า DB ไอพี $dns2 หรือไม่ Y/n : " confirm
if [[ y = $confirm || Y = $confirm ]]; then
cd
wget -q "http://$dns2/db.tar"
if [ -e 'db.tar' ]; then
read -p "    ┣ ชื่อตาราง DB เซิฟนี้ ➡️  : " namedb
read -p "    ╰ หัสผ่าน My_admin ➡️  : " passwd
cd
clear
cr
tar xf db.tar
rm db.tar
mysql -u root -p$passwd $namedb < database.sql
rm -f database.sql
echo "    ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮"
echo "    ┣ สถานะ ถ้าไม่มีเอ่อเร่อแสดงว่าผ่านเรียบร้อย "
echo "    ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯"

exit
else
clear
cr
echo "    ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━╮"
echo "    ┣ ไม่พบไฟล์ DB ของ $dns2 "
echo "    ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━╯"
exit
fi
else
clear
cr
echo "    ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮"
echo "    ┣ ยกเลิกคืนค่า DB ของเว็บ $dns2 "
echo "    ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯"
exit
fi
;;
3)
if [ -d /home/vps/public_html/ovpn ]; then
echo
else
mkdir /home/vps/public_html/ovpn
fi
clear
cr
echo "    ╭━━━━━━━━━━━━━━━━━━━╮"
echo "    ┣ ติดตั้งไฟล์ Ovpn ลง Panel      "
echo "    ┣━━━━━━━━━━━━━━━━━━━╯"
read -p "    ┣ Host/IP    : " Host
read -p "    ┣ ใส่เพโหลด  : " payload
read -p "    ┣ ตั้งชื่อไฟล์   : " Name
read -p "    ╰ ต้องการบันทึกหรือไม่ y/n  : " Edit
if [[ "$Edit" = "y" || "$Edit" = "Y" ]]; then
if [ -e /home/vps/public_html/ovpn/$Name.ovpn ]; then
clear
cr
echo "    ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━╮"
echo "    ┣ $Name มีชื่ออยู่ในระบบแล้ว      "
echo "    ╰━━━┳━━━━━━━━━━━┳━━━━━━━━━━━╯"
echo "    ╭━━━┻━━━━━━━━━━━┻━━━━━╮"
echo "    ┃ ต้องการติดตั้งทับไฟล์เดิมหรือไม่   "
echo "    ┣━━━━━━━━━━━━━━━━━━━━━╯"
read -p "    ╰━━  {y/n} : " Enter
if [[ "$Enter" = "y" || "$Enter" = "Y" ]]; then
clear
elif [[ "$Enter" = "$Enter" ]]; then
clear
cr
echo "           ╭━━━━━━━━━━━━━━╮ 
           ┣ ยกเลิกการตั้งค่าไฟล์
           ╰━━━━━━━━━━━━━━╯
 "
exit 0
fi
else
echo smile
fi
grep -E "^proto tcp" /etc/openvpn/1194.conf >/dev/null
if [ $? -eq 0 ]; then
proto="proto tcp"
if [[ "$payload" = "" ]]; then
remote="remote $Host 1194"
else
remote="remote $Host:1194@$payload 1194"
fi
proxy="http-proxy $Host 8080"

else
proto="proto udp"
remote="remote $Host 1194"
fi

cat > /home/vps/public_html/ovpn/$Name.ovpn <<-SMILE
auth-user-pass
client
dev tun
$proto
$remote
$proxy
connect-retry 1
connect-timeout 120
resolv-retry infinite
route-method exe
nobind
ping 5
ping-restart 30
persist-key
persist-tun
persist-remote-ip
mute-replay-warnings
verb 3
cipher none
comp-lzo
script-security 3

<ca>
$(cat /etc/openvpn/ca.pem)
</ca>
SMILE
IP=$(cat /usr/bin/ipsm)
clear
cr
echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        ┣ สร้างไฟล์เรียบร้อย
        ┣ โปรดนำลิ้งด้านล่างไปตั้งค่าเพิ่มไฟล์ในเว็บ      
        ┣ เข้าเว็บไซต์ > ตั้งค่า > เพิ่มไฟล์Ovpn
        ┣ LinkDownload  : http://$IP/ovpn/$Name.ovpn
        ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 "
exit 0
elif [[ "$Edit" = "$Edit" ]]; then
clear
cr
echo "           ╭━━━━━━━━━━━━━━╮ 
           ┣ ไม่ได้บันทึกการตั้งค่า
           ╰━━━━━━━━━━━━━━╯
 "
exit 0
fi
;;
4)
clear
cr
echo "    ╭━━━━━━━━━━━━━━━━━━━╮"
echo "    ┣ เซ็ตค่า AutoWallet      "
echo "    ╰━━━━━━━━━━━━━━━━━━━╯"
echo
echo " => ตั้งค่าโบนัส <= "
echo
read -p " ได้โบนัสเมื่อโอนขั้นต่ำกี่บาท   : " -e -i 50 mout
read -p " โบนัสที่จะได้รับกี่ %   : " -e -i 10 bonas
wget -q -O /home/vps/public_html/application/controllers/sm-api.php https://github.com/D1NFUCK3Rz/KAK-VPN/raw/main/wallet.txt
sed -i "s/50/$mout/g" /home/vps/public_html/application/controllers/sm-api.php
sed -i "s/10/$bonas/g" /home/vps/public_html/application/controllers/sm-api.php
echo "    ╭━━━━━━━━━━━━━━━━━━━━━━    "
echo "    ┣ ตั่งค่าของคุณคือ    "
echo "    ┣ เมื่อโอนขั้นต่ำ $mout บาท ได้รับเครดิตเพิ่ม $bonas %             "
echo "    ┣ การรองรับ : ยืนยันด้วยเลขที่อ้างอิงหรือวันเวลาโอนตามสลิป         "
echo "    ┣ หมายเหตุ  : ระบบจะตัดเครดิต 3% เมื่อลูกค้าเติมสำเร็จ           "
echo "    ╰━━━━━━━━━━━━━━━━━━━━━━   "

exit
;;
5)
clear
cr
echo "    ╭━━━━━━━━━━━━━━━━━━━╮"
echo "    ┣ กำหนดชื่อโฟร์เดอร์      "
echo "    ┣━━━━━━━━━━━━━━━━━━━╯"
read -p "    ┣> : " foder
apt-get install -y phpmyadmin
cd /home/vps/public_html
wget https://files.phpmyadmin.net/phpMyAdmin/4.8.5/phpMyAdmin-4.8.5-all-languages.zip
unzip phpMyAdmin-4.8.5-all-languages.zip
rm phpMyAdmin-4.8.5-all-languages.zip
mv phpMyAdmin-4.8.5-all-languages $foder
clear
cr
echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        ┣ ลิ้ง PHP Myadmin
        ┣ LinkDownload  : http://$IP/$foder
        ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 "
;;
6 )
cd /usr/bin
wget -q -O .menu https://github.com/D1NFUCK3Rz/KAK-VPN/raw/main/menu_pn.sh
chmod +x .menu
cd /home/vps/public_html
wget -q -O sm.tar https://github.com/D1NFUCK3Rz/KAK-VPN/raw/main//pnup.tar
tar xf sm.tar
rm sm.tar
open_scrip
echo "    ╭━━━━━━━━━━━━━━━━━━━━━━╮"
echo "    ┣ อัปเดตเว็บไซต์เรียบร้อย            "
echo "    ╰━━━━━━━━━━━━━━━━━━━━━━╯"
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

exit

fi

