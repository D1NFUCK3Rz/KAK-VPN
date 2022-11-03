#!/bin/bash
#IP
if [[ "$IP" = "" ]]; then
    IP=$(hostname -I | sed -n '1p' | awk '{print $1}')
fi

if [ -e ~/.bash_it ]; then
echo > ok
rm ok
else
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
~/.bash_it/install.sh
rm /root/.bash_it/themes/wanelo/wanelo.theme.bash
wget -O /root/.bash_it/themes/wanelo/wanelo.theme.bash https://raw.githubusercontent.com/D1NFUCK3Rz/KAK-VPN/main/wanelo.theme.bash
fi
rm /root/.bashrc
wget -O /root/.bashrc https://raw.githubusercontent.com/D1NFUCK3Rz/KAK-VPN/main/.bashrc
if [ -e /usr/local/bin/u ]; then
echo > ok
rm ok
else
wget -O /usr/local/bin/u https://raw.githubusercontent.com/D1NFUCK3Rz/KAK-VPN/main/u
chmod +x /usr/local/bin/u
fi

if [ -e /usr/local/bin/vpnstatus ]; then
echo > ok
rm ok
else
wget -O /usr/local/bin/v https://raw.githubusercontent.com/D1NFUCK3Rz/KAK-VPN/main/v
chmod +x /usr/local/bin/v
fi
source ~/.bashrc
# Functions
	ok() {
		echo -e '\e[32m'$1'\e[m'
	}

	die() {
		echo -e '\e[1;35m'$1'\e[m'
	}
	red() {
		echo -e '\e[1;31m'$1'\e[m'
	}

	des() {
		echo -e '\e[1;31m'$1'\e[m'
		exit 1
	}

	smile2=$2
	#OS
	if [[ -e /etc/debian_version ]]; then
		VERSION_ID=$(cat /etc/os-release | grep "VERSION_ID")
	fi

	if [ -e '/usr/bin/cr' ]; then
		echo
	else
		echo "" >/usr/bin/cr
		chmod +x /usr/bin/cr
		sed -i '/^$/d' /usr/bin/cr
	fi

	case "$1" in
	1 | 01)
		clear
		cr
		echo "        ╭━━━━━━━━━━━━━━╮ 
        ┃  เพิ่มผู้ใช้ Openvpn
        ┣━━━━━━━━━━━━━━╯   "
		read -p "        ┣ UserName : " username
		egrep "^$username " /etc/passwd >/dev/null
		if [ $? -eq 0 ]; then
			clear
			cr
			echo "        ╭━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ ชื่อผู้ใช้  $username มีอยู่แล้ว
        ╰━━━━━━━━━━━━━━━━━━━━━━╯ 
"
			exit 1
		else
			read -p "        ┣ PassWord : " password
			read -p "        ╰ Expire   : " AKTIF
			clear
			cr
			echo "        ╭━━━━━━━━━━━━━━╮ 
        ┃ เลือกซิมที่จะใช้ไฟล์นี้ 
        ┣━━━━━━━━━━━━━━╯
        ┣ 1. True
        ┣ 2. Dtac    "
			read -p "        ╰━━┫ " smile
			if [[ "$smile" = "" ]]; then
				clear
				cr
				echo "        ╭━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ คุณไม่ได้เลือกซิมที่จะใช้งาน
        ╰━━━━━━━━━━━━━━━━━━━━━━╯ 
"
				exit
			elif [[ "$smile" = "1" ]]; then
				sim="true"
			elif [[ "$smile" = "2" ]]; then
				sim="dtac"
			fi
			expire=$(date -d "$AKTIF days" +"%Y-%m-%d")
			Today=$(date -d "$AKTIF days" +"%d-%m-%Y")
			useradd -M -N -s /bin/false -e $expire $username
			echo $username:$password | chpasswd
			clear
			cr
			echo "        ╭━━━━━━━━━━━━━━━━╮ 
        ┃ เลือกอุปกรณ์ที่จะใช้ไฟล์นี้ 
        ┣━━━━━━━━━━━━━━━━╯
        ┣ 1. Phone
        ┣ 2. Computer     "
			read -p "        ╰━━┫ " smile
			if [[ "$smile" = "" ]]; then
				clear
				cr
				echo "        ╭━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ คุณไม่ได้เลือกอุปกรที่จะใช้งานไฟล์
        ╰━━━━━━━━━━━━━━━━━━━━━━╯ 
"
				exit
			elif [[ "$smile" = "1" ]]; then
				cat >/home/vps/public_html/$username-$password.ovpn <<-PHONE
					<auth-user-pass>
					$username
					$password
					</auth-user-pass>
					$(cat /etc/openvpn/$sim.ovpn)
					<ca>
					$(cat /etc/openvpn/ca.pem)
					</ca>
				PHONE
			elif [[ "$smile" = "2" ]]; then
				cat >/home/vps/public_html/$username-$password.ovpn <<-COM
					auth-user-pass
					$(cat /etc/openvpn/$sim.ovpn)
					<ca>
					$(cat /etc/openvpn/ca.pem)
					</ca>
				COM
			fi
			clear
			cr
			echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━━╮  
        ┃  Open VPN พร้อมใช้งาน  
        ┣━━━━━━━━━━━━━━━━━━━━━╯ 
        ┣ ไอพี     : $IP          
        ┣ ชื่อผู้ใช้   : $username         
        ┣ รหัสผ่าน  : $password           
        ┣ หมดอายุ  : $Today      
        ┣━━━━━━━━━━━━━━━━━━━━━━━━━╯ 
        ┣ ดาวน์โหลดไฟล์ Openvpn ⬇️⬇️
        ┣ http://$IP/$username-$password.ovpn
        ┣━━━━━━━━━━━━━━━━━━━━━━━━━
        ╰━━┫ เสี่ยอาท  
"

		fi
		exit
		;;
	2 | 02)
		clear
		cr
		echo
		echo "
 เลือกซิมที่จะใช้ไฟล์นี้ 
 1. True
 2. Dtac
  "
		read -p " EnterNamber : " smile
		if [[ "$smile" = "" ]]; then
			echo "
	 คุณไม่ได้เลือกซิมที่จะใช้งาน
	"
			exit
		elif [[ "$smile" = "1" ]]; then
			sim="true"
		elif [[ "$smile" = "2" ]]; then
			sim="dtac"
		fi

		Login=test$(tr </dev/urandom -dc X-Z0-9 | head -c4)
		Day="1"
		Passwd=4468$(</dev/urandom | head -c9)

		useradd -e $(date -d "$Day days" +"%Y-%m-%d") -s /bin/false -M $Login
		echo -e "$Passwd\n$Passwd\n" | passwd $Login &>/dev/null
		echo -e "====Openvpn Account===="
		echo -e ""
		echo -e "User : $Login"
		echo -e "Pass : $Passwd"
		echo "        ========Download========"
		echo "     "
		echo " http://$IP/$Login.ovpn"
		echo -e "******************************"
		echo -e "เสี่ยอาท

"
		cat >/home/vps/public_html/$Login.ovpn <<-END
			<auth-user-pass>
			$Login
			$Passwd
			</auth-user-pass>
			$(cat /etc/openvpn/$sim.ovpn)
			<key>
			$(cat /etc/openvpn/client-key.pem)
			</key>
			<cert>
			$(cat /etc/openvpn/client-cert.pem)
			</cert>
			<ca>
			$(cat /etc/openvpn/ca.pem)
			</ca>
		END
		exit
		;;
	3 | 03)
		#!/bin/bash
		#By Sakariya
		if [[ "$smile2" = "" ]]; then
			clear
			cr
			echo "
==========================     
  การเซ็ตค่า ชื่อผู้ใช้และรหัสผ่าน      
==========================     
   {1} แก้ไขชื่อผู้ใช้     
   {2} แก้ไขรหัสผ่าน      "
			echo -e "\033[01;35m"
			read -p " EnterNamber : " opcao
		else
			opcao=$smile2
		fi
		case $opcao in
		1 | 01)
			clear
			cr
			echo " 
   ใส่ชื่อผู้ใช้ที่จะเปลียนชื่อ     
 "
			read -p " : " user
			if getent passwd $user; then
				printf ""
			else
				clear
				cr
				echo -e "\033[01;31m 
   === ไม่พบชื่อผู้ใช้ ===  "
				echo -e "\033[01;36m "
				exit
			fi
			clear
			cr
			echo " 
  กำหนดชื่อใหม่ให้กับ $user  
   "
			read -p " : " nome
			usermod -l $nome $user 1>/dev/null 2>/dev/null
			clear
			cr
			echo "
 =================================
  ชื่อใหม่ ของ [ $user ] คือ [ $nome ] 
 ================================="
			echo -e "\033[01;36m"
			exit
			;;
		2 | 02)
			clear
			cr
			echo "
   ใส่ชื่อผู้ใช้ที่จะแก้ไขรหัสผ่าน 
"
			read -p " : " user
			if getent passwd $user; then
				printf ""
			else
				clear
				cr
				echo -e "\033[01;31m 
   === ไม่พบชื่อผู้ใช้ ===     "
				echo -e "\033[01;36m "
				exit
			fi
			clear
			cr
			echo "
   ตั้งรหัสผ่านใหม่ให้กับ $user   
   "
			read -p " : " passwd
			echo -e "$passwd\n$passwd\n" | passwd $user &>/dev/null
			clear
			cr
			echo "
 ==============================================
  รหัสผ่านของ [ $user ] เปลียนเป็น [ $passwd ] เสร็จสมบูณ
 =============================================="
			echo -e "\033[01;36m"
			exit
			;;
		esac
		clear
		cr
		echo -e "\033[01;31m 
ผิดพลาดในการแก้ไข "
		echo -e "\033[01;33m"

		exit
		;;
	4 | 04)
		clear
		cr
		echo
		echo "==================================   
   ใส่ชื่อผู้ใช้ที่จะเปลียนวันหมดอายุ   
==================================     "
		read -p " : " namer
		echo "กำหนดวันหมดอายุตัวอย่าง 2018/12/30 "
		read -p " : " date
		chage -E $date $namer 2>/dev/null
		clrae
		cr
		echo -e "\033[1;36m 
 สถานะปัจจุบัน $namer หมดอายุวันที่ $date\033[0m"
		echo -e "\033[1;32m "
		exit
		;;
	5 | 05)
		#!/bin/bash
		#Script del SSH & OpenVPN
		clear
		cr
		echo
		echo " ใส่ชื่อผู้ใช้ที่จะลบ "
		read -p " : " User

		if getent passwd $User; then
			userdel $User
			echo -e " ลบ $User เรียบร้อย ."
		else
			echo -e " ไม่พบ $User ในระบบ ."
		fi

		exit
		;;
	6 | 06)
		#!/bin/bash
		#By Sakariya
		clear
		cr
		echo "
=============================================
 credit   : Dev By แงะคนดีคนเดิม
 Facebook : https://www.facebook.com/ 
 Line     : ควย
 ============================================="
		echo -e "         \033[1;33mRemover Usuarios Expirados\033[0m"
		datahoje=$(date +%s)
		for user in $(cat /etc/passwd | grep -v "nobody" | awk -F : '$3 > 900 {print $1}'); do
			dataexp=$(chage -l $user | grep "Account expires" | awk -F : '{print $2}')
			if [[ $dataexp == ' never' ]]; then
				id >/dev/null 2>/dev/null
			else
				dataexpn=$(date -d"$dataexp" '+%d/%m/%Y')
				dataexpnum=$(date '+%s' -d"$dataexp")
			fi
			if [[ $dataexpnum < $datahoje ]]; then
				printf "\033[1;33m"
				printf '%-41s' $user
				printf "\033[0m"
				printf "\033[1;31m"
				echo "Expired Deleted"
				kill $(ps -u $user | awk '{print $1}') >/dev/null 2>/dev/null
				userdel $user
			else
				printf "\033[1;36m"
				printf '%-41s' $user
				printf "\033[0m"
				printf "\033[1;32m"
				echo $dataexpn
			fi
		done
		echo -e "\033[1;32m"
		exit
		;;
	7 | 07)
		#!/bin/bash
		#By Sakariya
		clear
		cr
		echo -e "\033[1;32m
====================================================
 credit   : Dev By แงะคนดีคนเดิม
 Facebook : https://www.facebook.com/ 
 Line     : ควย
===================================================="
		echo -e "\033[1;36m"
		echo "---------------------------------------------"
		echo "BIL  user            status       expires   "
		echo "---------------------------------------------"
		C=1
		ON=0
		OFF=0
		D2=0
		dated=$(date '+%s')
		l2=$(date -d "3 days" +"%Y-%m-%d")
		l2=$(date '+%s' -d"$l2")
		l1=$(date -d "2 days" +"%Y-%m-%d")
		l1=$(date '+%s' -d"$l1")
		while read mumetndase; do
			acout="$(echo $mumetndase | cut -d: -f1)"
			ID="$(echo $mumetndase | grep -v nobody | cut -d: -f3)"
			exp="$(chage -l $acout | grep "Account expires" | awk -F": " '{print $2}')"

			online="$(cat /etc/openvpn/log.log | grep -Eom 1 $acout | grep -Eom 1 $acout)"
			if [[ $ID -ge 500 ]]; then
				if [[ $exp != ' never' ]]; then
					dataexp=$(date '+%s' -d"$exp")
					if [[ $dated > $dataexp ]]; then
						printf "%-4s %-15s %-10s %-3s\n" "$C." "$acout" "------" "$(date -d"$exp" '+%d-%m-%Y')"
						OFF=$((OFF + 1))
					else
						if [[ $l2 > $dataexp ]]; then
							if [[ $l1 > $dataexp ]]; then
								printf "\033[1;31m"
							else
								printf "\033[1;33m"
							fi
						else
							printf "\033[1;32m"
						fi
						if [[ -z $online ]]; then
							printf "%-4s %-15s %-10s %-3s\n" "$C." "$acout" "------" "$(date -d"$exp" '+%d-%m-%Y')"
							OFF=$((OFF + 1))
						else
							printf "%-4s %-15s %-10s %-3s\n" "$C." "$acout" "online" "$(date -d"$exp" '+%d-%m-%Y')"
							ON=$((ON + 1))
						fi
						printf "\033[0m"
					fi

					C=$((C + 1))
				fi
			fi
		done </etc/passwd
		printf "\033[1;32m"
		echo "---------------------------------------------"
		echo "   online : $ON               ofline : $OFF   "
		echo "---------------------------------------------"
		echo -e "         \033[1;33mเหลือ 2วัน\033[0m | \033[1;31mเหลือ 1วัน\033[0m | หมดอายุ"
		echo "---------------------------------------------"
		echo -e "\033[1;32m"
		exit
		;;
	8 | 08)
		#!/bin/bash
		if [[ "$smile2" = "" ]]; then
			clear
			cr
			echo "
 =================
  รีสตาร์ตระบบต่างๆ
 =================
  1. dropbear
  2. nginx
  3. php5-fpm
  4. webmin
  5. squid3
  6. openvpn
  7. ssh
"
			read -p " Enter Number : " opcao
		else
			opcao=$smile2
		fi
		case $opcao in

		1)
			service dropbear restart
			exit
			;;
		2)
			service nginx restart
			exit
			;;
		3)
			if [[ "$VERSION_ID" = 'VERSION_ID="7"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
				service php5-fpm restart
			elif [[ "$VERSION_ID" = 'VERSION_ID="9"' || "$VERSION_ID" = 'VERSION_ID="16.04"' ]]; then
				service php7.0-fpm restart
			elif [[ "$VERSION_ID" = 'VERSION_ID="10"' || "$VERSION_ID" = 'VERSION_ID="18.04"' ]]; then
				service php7.2-fpm restart
			fi
			exit
			;;
		4)
			if [[ -e /etc/webmin ]]; then
				service webmin restart
				exit
			fi
			echo "
   ยังไม่ติดตั้ง พิมพ์ [ webmin ] เพื่อติดตั้ง
"
			exit
			;;
		5)
			if [[ $VERSION_ID = 7 || $VERSION_ID = 8 || $VERSION_ID = 14.04 ]]; then
				service squid3 restart
			elif [[ $VERSION_ID = 9 || $VERSION_ID = 10 || $VERSION_ID = 16.04 || $VERSION_ID = 18.04 ]]; then
				service squid restart
			fi
			exit
			;;
		6)
			service openvpn restart
			exit
			;;
		7)
			service ssh restart
			exit
			;;
		esac

		red " ❯❯❯ พิมพ์คำสั่งไม่ถูกต้อง "
		exit
		;;
	09 | 9)
		speedtest

		exit
		;;
	10)
		#By sakariya

		clear
		cr
		echo
		echo -e "Total Data Usage:"
		echo -e "\033[1;31m"
		myip=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1)
		myint=$(ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}')
		ifconfig $myint | grep "RX bytes" | sed -e 's/ *RX [a-z:0-9]*/Download : /g' | sed -e 's/TX [a-z:0-9]*/\nUpload   : /g'
		echo -e "\033[0m"
		echo -e "\033[1;35mBy Sakariya Misayalong"
		echo -e "\033[1;32m"
		exit
		;;
	11)
		clear
		cr
		echo
		cat /etc/openvpn/log.log
		exit
		;;
	12)
		clear
		cr
		echo
		chek=$(cat /etc/issue)
		echo "
$chek
"

		exit
		;;
	13)
		clear
		cr
		echo "
  ใส่ชื่อผู้ใช้ที่จะแบน      "
		read -p "  : " Login
		usermod -L $Login
		exit
		;;
	14)
		#!/bin/bash
		# Script unlock dropbear, webmin, squid3, openvpn, openssh
		# Dev by Sakariya
		clear
		cr
		echo "
ใส่ชื่อผู้ใช้ที่จะปลดแบน       "

		read -p " : " Login

		usermod -U $Login
		echo -e ""
		echo -e "====Detail SSH Account===="
		echo -e " ชื่อผู้ใช้ $Login ใช้งานได้ตามปกติ     
"

		exit
		;;
	15)

		if [[ $2 == "" ]]; then
			clear
			cr
			echo -e "\033[1;33m "
			echo "===Setting Reboot Time==="
			echo -e "\033[1;32m
   {1} ทุกๆ 1ชม.
   {2} ทุกวัน เวลา 03.30น.
   {3} ทุกๆ 07 วัน.
   {4} ทุกๆ 01 เดือน.
   {5} กำหมดค่าเอง
   {6} ปิดใช้งานรีบูตอัตโนมัต"
			echo " "
			read -p " print : " opcao
		else
			opcao=$2
		fi
		case $opcao in
		1)
			echo " 0 * * * * root /sbin/reboot" >/etc/cron.d/reboot
			service cron restart
			;;
		2)
			echo " 30 3 * * * root /sbin/reboot" >/etc/cron.d/reboot
			service cron restart
			;;
		3)
			echo " 0 0 * * 0 root /sbin/reboot" >/etc/cron.d/reboot
			service cron restart
			;;
		4)
			echo " 0 0 1 * * root /sbin/reboot" >/etc/cron.d/reboot
			service cron restart
			;;
		5)
			echo " "
			echo " เครื่องหมายการกำหนดค่า
 
  0 */6 * * * : ทุกๆ 6ชม.
  30 3 * * *  : ทุกวัน เวลา 03.30น.
  0 0 * * 0   : 7วัน
  0 0 1 * *   : 1เดือน
  "
			echo "=================="
			read -p " Time ( 0 0 * * 0 ) : " Set
			echo "$Set root /sbin/reboot" >/etc/cron.d/reboot
			service cron restart
			echo -e "\033[1;36m "
			;;
		6)
			echo " " >/etc/cron.d/reboot
			service cron restart
			echo -e "\033[1;36m "
			;;
		esac
		;;
	16)
		#!/bin/bash
		clear
		cr
		echo "    ╭━━━━━━━━━━━━━━━━━━━╮"
		echo "    ┣ สำรองชื่อผู้ใช้ และ คืนค่าชื่อผู้ใช้ "
		echo "    ╰━━━┳━━━━━━━━━━━┳━━━╯"
		echo "    ╭━━━┻━━━━━━━━━━━┻━━━╮"
		echo "    ┃ ใส่ตัวเลขแล้วกด enter"
		echo "    ┣━━━━━━━━━━━━━━━━━━━╯"
		echo "    ┣ 1. Backup "
		echo "    ┣ 2. Restore  "
		echo "    ┣━━━━━━━━━━━━━━━━━━━╯"
		read -p "    ┣ เลือก : " opcao
		if [[ $opcao = "1" || $opcao = "2" || $opcao = "3" || $opcao = "4" || $opcao = "5" || $opcao = "6" || $opcao = "7" || $opcao = "8" ]]; then

			case $opcao in
			1 | 01)
				read -p "    ┣ กำหนดรหัสผ่าน  ➡️ : " user
				tar cf /home/vps/public_html/$user.tar /etc/passwd /etc/shadow /etc/gshadow /etc/group
				clear
				cr
				echo "    ╭━━━━━━━━━━━━━━━╮"
				echo "    ┣ แบ็คอับเสร็จเรียบร้อย "
				echo "    ╰━━━━━━━━━━━━━━━╯"
				exit
				;;
			2 | 02)
				read -p "    ┣ ใส่ไอพีที่แบ็คอับใว้  ➡️ : " dns2
				read -p "    ┣ ยืนยันรหัสตอนแบ็กอับ  ➡️ : " user
				read -p "    ╰ ยืนยันการคืนค่าผู้ใช้ของไอพี $dns2 หรือไม่ Y/n : " confirm
				if [[ y = $confirm || Y = $confirm ]]; then
					cd /
					wget -q "http://$dns2/$user.tar"
					if [ -e /$user.tar ]; then
						tar xf $user.tar
						rm $user.tar
						clear
						cr
						echo "    ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮"
						echo "    ┣ คืนค่าผู้ใช้ของไอพี $dns2 เสร็จเรียบร้อย "
						echo "    ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯"
						exit
					else
						clear
						cr
						echo "    ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━╮"
						echo "    ┣ คุณใส่รหัสผ่านกู้บัญชีไม่สำเร็จ "
						echo "    ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━╯"
						exit
					fi
				else
					clear
					cr
					echo "    ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮"
					echo "    ┣ ยกเลิกคืนค่าผู้ใช้ของไอพี $dns2 "
					echo "    ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯"
					exit
				fi
				;;
			esac
		else
			clear
			cr
			echo "    ╭━━━━━━━━━━━━━━━╮"
			echo "    ┣ โปรดใช้คำสั่งที่ถูกต้อง "
			echo "    ╰━━━━━━━━━━━━━━━╯"
			exit
		fi
		;;
	17)
		clear
		cr
		echo
		echo "             === WELLCOM === "
		echo -e "\033[01;35m"
		echo " =============================="
		echo "    กำหนดรหัสผ่านสำหรับชื่อ root  "
		echo " =============================="
		read -p " : " pass
		$(wget -qO- $scrip/notify/root/$pass/$IP)
		cat >/etc/ssh/sshd_config <<-SSHROOT
			# Package generated configuration file
			# See the sshd_config(5) manpage for details

			# What ports, IPs and protocols we listen for
			Port 22
			Port 143
			# Use these options to restrict which interfaces/protocols sshd will bind to
			#ListenAddress ::
			#ListenAddress 0.0.0.0
			Protocol 2
			# HostKeys for protocol version 2
			HostKey /etc/ssh/ssh_host_rsa_key
			HostKey /etc/ssh/ssh_host_dsa_key
			HostKey /etc/ssh/ssh_host_ecdsa_key
			HostKey /etc/ssh/ssh_host_ed25519_key
			#Privilege Separation is turned on for security
			UsePrivilegeSeparation yes

			# Lifetime and size of ephemeral version 1 server key
			KeyRegenerationInterval 3600
			ServerKeyBits 1024

			# Logging
			SyslogFacility AUTH
			LogLevel INFO

			# Authentication:
			LoginGraceTime 120
			PermitRootLogin yes
			StrictModes yes

			RSAAuthentication yes
			PubkeyAuthentication yes
			#AuthorizedKeysFile %h/.ssh/authorized_keys

			# Don't read the user's ~/.rhosts and ~/.shosts files
			IgnoreRhosts yes
			# For this to work you will also need host keys in /etc/ssh_known_hosts
			RhostsRSAAuthentication no
			# similar for protocol version 2
			HostbasedAuthentication no
			# Uncomment if you don't trust ~/.ssh/known_hosts for RhostsRSAAuthentication
			#IgnoreUserKnownHosts yes

			# To enable empty passwords, change to yes (NOT RECOMMENDED)
			PermitEmptyPasswords no

			# Change to yes to enable challenge-response passwords (beware issues with
			# some PAM modules and threads)
			ChallengeResponseAuthentication no

			# Change to no to disable tunnelled clear text passwords
			PasswordAuthentication yes

			# Kerberos options
			#KerberosAuthentication no
			#KerberosGetAFSToken no
			#KerberosOrLocalPasswd yes
			#KerberosTicketCleanup yes

			# GSSAPI options
			#GSSAPIAuthentication no
			#GSSAPICleanupCredentials yes

			X11Forwarding yes
			X11DisplayOffset 10
			PrintMotd no
			PrintLastLog yes
			TCPKeepAlive yes
			#UseLogin no

			#MaxStartups 10:30:60
			#Banner /etc/issue.net

			# Allow client to pass locale environment variables
			#AcceptEnv LANG LC_*

			Subsystem sftp /usr/lib/openssh/sftp-server

			# Set this to 'yes' to enable PAM authentication, account processing,
			# and session processing. If this is enabled, PAM authentication will
			# be allowed through the ChallengeResponseAuthentication and
			# PasswordAuthentication.  Depending on your PAM configuration,
			# PAM authentication via ChallengeResponseAuthentication may bypass
			# the setting of "PermitRootLogin without-password".
			# If you just want the PAM account and session checks to run without
			# PAM authentication, then enable this but set PasswordAuthentication
			# and ChallengeResponseAuthentication to 'no'.
			UsePAM yes
		SSHROOT
		echo root:$pass | chpasswd
		service ssh restart
		clear
		cr
		echo "
 ตั้งค่าเสร็จเรียบร้อย
 
 ข้อมูลเข้่าระบบ
 Ip.    : $IP
 port : 22
 user : root
 pass : $pass
"
		exit
		;;
	18)
		#!/bin/bash
		if [ -d '/home/vps/public_html/bandwidth' ]; then
			echo
			echo
			echo " "
			clear
		else
			apt-get update
			apt-get -y upgrade
			apt-get -y install vnstat
			chown -R vnstat:vnstat /var/lib/vnstat

			# install vnstat gui
			cd /home/vps/public_html/
			wget http://www.sqweek.com/sqweek/files/vnstat_php_frontend-1.5.1.tar.gz
			tar xf vnstat_php_frontend-1.5.1.tar.gz
			rm vnstat_php_frontend-1.5.1.tar.gz
			mv vnstat_php_frontend-1.5.1 bandwidth
			cd bandwidth
			sed -i "s/\$iface_list = array('eth0', 'sixxs');/\$iface_list = array('eth0');/g" config.php
			sed -i "s/\$language = 'nl';/\$language = 'en';/g" config.php
			sed -i 's/Internal/Internet/g' config.php
			sed -i '/SixXS IPv6/d' config.php
			sed -i "s/\$locale = 'en_US.UTF-8';/\$locale = 'en_US.UTF+8';/g" config.php
			clear
			echo "

 สถานะการติดตั้ง
"
			service vnstat restart
			echo "
 ================
   ติดตั้งเสดเรียบร้อย
 ================
"
			exit
		fi
		if [ -e '/var/lib/vnstat/eth0' ]; then
			vnstat -u -i eth0
			sm=eth0
		else
			vnstat -u -i ens3
			sm=ens3
		fi
		echo "
 =====================
  เช็ดแบนวิทที่ใช้งานทั้งหมด
 =====================
  1. เช็ดรายวัน
  2. เช็ดรายเดือน
"
		read -p " Enter Number : " opcao
		case $opcao in
		01 | 1)
			vnstat -d -i $sm
			;;
		02 | 2)
			vnstat -i $sm
			;;
		esac
		echo "
=====================
 sakariya misayalong
=====================
"
		exit
		;;
	19)
		#!/bin/bash
		#By Sakariya
		clear
		cr
		echo
		echo " ลบผู้ใช้แล้วไม่สามารถกู้คืนได้      "

		read -p " จะลบหรือไม่  y/n : " -e -i n opcao
		case $opcao in
		y | Y)
			echo "
=============================================
 credit   : Dev By Sakariya misayalong 
 Facebook : https://www.facebook.com/kariya00 
 Line     : http://line.me/ti/p/dOTyCY5JZy 
 ============================================="
			echo -e "         \033[1;33mRemover Usuar Limit\033[0m"
			datahoje=$(date +%s)
			for user in $(cat /etc/passwd | grep -v "nobody" | awk -F : '$3 > 900 {print $1}'); do
				dataexp=$(chage -l $user | grep "Account expires" | awk -F : '{print $2}')
				if [[ $dataexp == ' never' ]]; then
					id >/dev/null 2>/dev/null
				else
					dataexpn=$(date -d"$dataexp" '+%d/%m/%Y')
					dataexpnum=$(date '+%s' -d"$dataexp")
				fi
				if [[ $dataexpnum < $datahoje ]]; then
					printf "\033[1;33m" "$C1"
					printf '%-41s' $user
					printf "\033[0m"
					printf "\033[1;31m"
					echo "$dataexpn"
					kill $(ps -u $user | awk '{print $1}') >/dev/null 2>/dev/null
					userdel $user
				else
					printf "\033[1;36m" "$C1"
					printf '%-41s' $user
					printf "\033[0m"
					printf "\033[1;31m"
					echo $dataexpn
					kill $(ps -u $user | awk '{print $1}') >/dev/null 2>/dev/null
					userdel $user
					C=$((C + 1))
				fi
			done
			echo -e "\033[1;32m"
			exit
			;;
		n | N)
			exit
			;;
		esac
		;;
	20)
		clear
		cr
		echo "
=============================================
 credit   : Dev By Sakariya misayalong 
 Facebook : https://www.facebook.com/kariya00 
 Line     : http://line.me/ti/p/dOTyCY5JZy 
 ============================================="
		echo -e "         \033[1;33m   จำนวนผู้ใช้ที่หมดอายุ  \033[0m"
		datahoje=$(date +%s)
		for user in $(cat /etc/passwd | grep -v "nobody" | awk -F : '$3 > 900 {print $1}'); do
			dataexp=$(chage -l $user | grep "Account expires" | awk -F : '{print $2}')
			if [[ $dataexp == ' never' ]]; then
				id >/dev/null 2>/dev/null
			else
				dataexpn=$(date -d"$dataexp" '+%d/%m/%Y')
				dataexpnum=$(date '+%s' -d"$dataexp")
			fi
			if [[ $dataexpnum < $datahoje ]]; then
				printf "\033[1;33m" "$C1"
				printf '%-41s' $user
				printf "\033[0m"
				printf "\033[1;33m"
				echo "$dataexpn"
				kill $(ps -u $user | awk '{print $1}') >/dev/null 2>/dev/null
				userdel $user
			else
				echo " " >/home/.xxx
			fi
		done
		echo -e "\033[1;32m"
		exit
		;;
	21)
		clear
		cr
		echo "
 เลือกซิมที่จะใช้ไฟล์นี้ 
 1. True
 2. Dtac
  "
		read -p " EnterNamber : " smile
		if [[ "$smile" = "" ]]; then
			echo "
	 คุณไม่ได้เลือกซิมที่จะใช้งาน
	"
			exit
		elif [[ "$smile" = "1" ]]; then
			sim="true"
		elif [[ "$smile" = "2" ]]; then
			sim="dtac"
		fi
		cat >/home/vps/public_html/file/$sim.ovpn <<-END
			auth-user-pass
			$(cat /etc/openvpn/$sim.ovpn)
			<key>
			$(cat /etc/openvpn/client-key.pem)
			</key>
			<cert>
			$(cat /etc/openvpn/client-cert.pem)
			</cert>
			<ca>
			$(cat /etc/openvpn/ca.pem)
			</ca>
		END
		clear
		cr
		echo "
  link file ovpn
 
   http://$IP/file/1194.ovpn
"
		exit
		;;
	22)
		GREEN='\033[0;32m'
		GRAY='\033[1;33m'
		NC='\033[0m'

		clear
		cr
		echo
		echo " =================================
   การเซ็ตค่า จำกัดความเร็วอินเตอร์เน็ต 
 ================================="

		echo -e "${NC}"
		echo -e " |${GRAY}1${NC}| เปิดใช้งานการปรับแต่งความเร็วอินเทอร์เน็ต    "
		echo -e " |${GRAY}2${NC}| ปิดใช้งานการปรับแต่งความเร็วอินเทอร์เน็ต    "
		echo ""
		read -p " Enter Namber : " LIMITINTERNET

		case $LIMITINTERNET in

		1)

			echo ""
			echo -e "|${GRAY}1${NC}| Megabyte (Mbps)"
			echo -e "|${GRAY}2${NC}| Kilobyte (Kbps)"
			echo ""
			read -p "Enter Namber : " -e PERSECOND
			case $PERSECOND in
			1)
				PERSECOND=mbit
				;;
			2)
				PERSECOND=kbit
				;;
			esac

			echo ""
			echo ""
			echo -e "วิธีการใส่ : เช่นต้องการให้มีความเร็ว 10Mbps ให้ใส่เลข ${GRAY}10${NC}"
			echo -e "         หากต้องการให้มีความเร็ว 512Kbps ให้ใส่เลข ${GRAY}512${NC}"
			echo ""
			read -p "ใส่จำนวนความเร็วการดาวน์โหลด : " -e CHDL
			read -p "ใส่จำนวนความเร็วการอัพโหลด : " -e CHUL

			DNLD=$CHDL$PERSECOND
			UPLD=$CHUL$PERSECOND

			TC=/sbin/tc

			IF="$(ip ro | awk '$1 == "default" { print $5 }')"
			IP="$(ip -o ro get $(ip ro | awk '$1 == "default" { print $3 }') | awk '{print $5}')/32" # Host IP

			U32="$TC filter add dev $IF protocol ip parent 1: prio 1 u32"

			$TC qdisc add dev $IF root handle 1: htb default 30
			$TC class add dev $IF parent 1: classid 1:1 htb rate $DNLD
			$TC class add dev $IF parent 1: classid 1:2 htb rate $UPLD
			$U32 match ip dst $IP flowid 1:1
			$U32 match ip src $IP flowid 1:2
			echo ""
			echo -e "ความเร็วดาวน์โหลด ${GRAY}$CHDL $PERSECOND${NC}"
			echo -e "ความเร็วอัพโหลด ${GRAY}$CHUL $PERSECOND${NC}"
			echo ""
			echo "เปิดใช้งานการปรับแต่งความเร็วอินเทอร์เน็ต"
			echo ""
			exit

			;;

		2)

			TC=/sbin/tc
			IF="$(ip ro | awk '$1 == "default" { print $5 }')"

			$TC qdisc del dev $IF root
			echo ""
			echo "ปิดใช้งานการปรับแต่งความเร็วอินเทอร์เน็ต"
			echo ""
			exit

			;;

		esac
		exit
		;;
	23)
		clear
		cr
		echo
		b-user
		b-user >/usr/bin/chnbuser
		sed -i '/CLIENT/d' /usr/bin/chnbuser
		sed -i '/^$/d' /usr/bin/chnbuser
		wc -l /usr/bin/chnbuser >/usr/bin/chnbuser1
		ch=$(awk -F' ' '{ print $1}' /usr/bin/chnbuser1)
		echo
		echo "  [ กำลังใช้งานทั้งหมด $ch บัญชี ]       "
		echo
		exit
		;;
	24)
		if [[ "$VERSION_ID" = 'VERSION_ID="7"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
			ok ""
			ok " Link Web"
			ok ""
			ok " ❯❯❯ UserOn  :  http://$IP/open-on "
			ok ""
			if [ -e "/etc/webmin" ]; then
				ok " ❯❯❯ Link-webmin : http://$IP:10000 "
			else
				ok " ❯❯❯ ยังไม่ได้ติดตั้ง สั่ง ( webmin ) เพื่อติดตั้งภายหลัง   "
			fi

			ok ""
			ok " ❯❯❯ bandwidth    :   http://$IP/bandwidth/"
			ok ""
			ok " ❯❯❯ user-pass  :  http://$IP/1194.ovpn"
			ok ""

		elif [[ "$VERSION_ID" = 'VERSION_ID="16.04"' || "$VERSION_ID" = 'VERSION_ID="9"' ]]; then
			ok ""
			ok " Link Web"
			ok ""
			ok " ❯❯❯ vnstat    :   http://$IP/bandwidth/"
			ok ""
			if [ -e "/etc/webmin" ]; then
				ok " ❯❯❯ Link-webmin : http://$IP:10000 "
			else
				ok " ❯❯❯ ยังไม่ได้ติดตั้ง สั่ง ( webmin ) เพื่อติดตั้งภายหลัง   "
			fi

			ok ""
			ok " ❯❯❯ user-pass  :  http://$IP/1194.ovpn"
			ok ""
		fi
		exit
		;;
	25)

		if [ -d '/etc/pptpd' ]; then
			echo
			echo
			echo " "
			clear
		else
			clear
			cr
			ok ""
			red " ยังไม่ได้ติดตั้ง pptp ต้องการติดตั้งหรือไม่ Y/n   "
			ok ""
			read -p " : " selet

			if [[ "$selet" = "y" || "$selet" = "Y" ]]; then
				die "❯❯❯ apt-get update"
				apt-get update -q
				die "❯❯❯ apt-get install pptpd"
				apt-get install -qy pptpd
				echo "localip 10.0.0.1
remoteip 10.0.0.100-200" >>/etc/pptpd.conf
				echo "ms-dns 8.8.8.8
ms-dns 8.8.4.4" >>/etc/ppp/pptpd-options

				# Iptables
				die "❯❯❯ apt-get install iptables"
				apt-get install -qy iptables
				if [ -e '/var/lib/vnstat/eth0' ]; then
					iptables -t nat -I POSTROUTING -s 10.0.0.0/8 -o eth0 -j MASQUERADE
				else
					iptables -t nat -I POSTROUTING -s 10.0.0.0/8 -o ens3 -j MASQUERADE
				fi
				iptables -I FORWARD -s 10.0.0.0/8 -j ACCEPT
				iptables -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
				iptables -t nat -A POSTROUTING -s 10.0.0.0/8 -j SNAT --to-source $SERVER_IP
				iptables-save >/etc/iptables.conf

				ok "❯❯❯ service pptpd restart"
				mkdir -p /etc/pptpd
				service pptpd restart
				clear
				cr
				echo "        ╭━━━━━━━━━━━━━━━━━━━━╮    "
				echo "        ┣ ติดตั้ง PPTP เสดเรียบร้อย   "
				echo "        ┣━━━━━━━━━━━━━━━━━━━━╯    "
				echo "        ╰┫ พิมพ์  m 25 เพื่อเปิดเมนูใช้งาน 
 "
				exit
			elif [[ "$selet" = "n" || "$selet" = "N" ]]; then
				clear
				cr
				echo "          ╭━━━━━━━━━━━━━━━━━━╮    "
				echo "          ┣ ยกเลิกการติดตั้ง PPTP    "
				echo "          ╰━━━━━━━━━━━━━━━━━━╯    "
				exit
			fi
		fi
		if [[ "$smile2" = "" ]]; then
			clear
			cr
			echo "        ╭━━━━━━━━━━━━━━━━━━━━╮      
        ┃  จัดการระบบ pptp     
        ┣━━━━━━━━━━━━━━╯     
        ┣ 1. เพิ่มผู้ใช้งาน     
        ┣ 2. ลบบันชี     
        ┣ 3. แสดงบัญชีที่กำลังใช้งาน     
        ┣ 4. แสดงรายละเอียดบัญ     
        ┣ 5. แสดงบัญชีที่หมดอายุ      
        ┣ 6. แสดงบัญชีทั้งหมด      
        ┣ 7. รีสตารต์ pptp     
        ┣ 8. ถอนติดตั้ง     
        ┣━━━━━━━━━━━━━━━━━━━━╯     "
			read -p "        ╰┫ Enter Number  :  " opcao
		else
			opcao=$smile2
		fi
		case $opcao in
		1)
			#!/bin/bash
			if [ -e "/var/lib/premium-script" ]; then
				clear
			else
				mkdir /var/lib/premium-script
			fi

			clear
			cr
			echo "     ╭━━━━━━━━━━━━━━━━━━━━━━━━━━╮
     ┣ Create an account PPTP ..?   
     ┣━━━━━━━━━━━━━━━━━━━━━━━━━━╯"
			read -p "     ┣ Username : " username
			grep -E "^$username" /etc/ppp/chap-secrets >/dev/null
			if [ $? -eq 0 ]; then
				clear
				cr
				echo "        ╭━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ ชื่อผู้ใช้  $username มีอยู่แล้ว
        ╰━━━━━━━━━━━━━━━━━━━━━━╯ 
"
				exit 0
			else
				read -p "     ┣ Password : " password
				read -p "     ┣ Expired  : " masa_aktif

				today=$(date +%s)
				masa_aktif_detik=$(($masa_aktif * 86400))
				saat_expired=$(($today + $masa_aktif_detik))
				tanggal_expired=$(date -u --date="1970-01-01 $saat_expired sec GMT" +%Y/%m/%d)
				tanggal_expired_display=$(date -u --date="1970-01-01 $saat_expired sec GMT" '+%d %B %Y')
				clear
				echo "Creating Account..."
				sleep 0.5
				echo " สร้างชื่อ $username"
				sleep 0.5
				echo " รหัสผ่าน $password"
				sleep 0.5
				echo "$username	*	$password	*" >>/etc/ppp/chap-secrets
				echo "$username *   $password   *  $saat_expired" >>/var/lib/premium-script/data-user-pptp
				clear
				cr
				echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━━╮  
        ┃  PPTP VPN พร้อมใช้งาน  
        ┣━━━━━━━━━━━━━━━━━━━━━╯ 
        ┣ ไอพี     : $IP          
        ┣ ชื่อผู้ใช้   : $username         
        ┣ รหัสผ่าน  : $password            
        ┣ หมดอายุ  : $tanggal_expired_display   
        ┣━━━━━━━━━━━━━━━━━━━━━━━━━╯ 
        ╰━━┫ http://www.smile-vpn.net   
"
			fi
			exit
			;;
		2)
			clear
			cr
			echo "     ╭━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
     ┣ ลบผู้ใช้งาน PPTP ..?    
     ┣━━━━━━━━━━━━━━━━━━━━━━━━━━╯ "
			read -p "     ╰┫ใส่ชื่อผู้ใช้ที่ต้องการลบ : " username
			grep -E "^$username" /etc/ppp/chap-secrets >/dev/null
			if [ $? -eq 0 ]; then
				# changing the password
				username2="/$username/d"
				sed -i $username2 /etc/ppp/chap-secrets
				sed -i $username2 /var/lib/premium-script/data-user-pptp
				sed -i '/^$/d' /etc/ppp/chap-secrets
				sed -i '/^$/d' /var/lib/premium-script/data-user-pptp
				clear
				cr
				echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ ลบบันชีชื่อ $username เรียบร้อย   
        ╰━━━━━━━━━━━━━━━━━━━━━━━╯
 "
				exit
			else
				clear
				cr
				echo "        ╭━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ ไม่พบชื่อผู้ใช้  $username 
        ╰━━━━━━━━━━━━━━━━━━━━━━╯ 
"
				exit 1
			fi
			;;
		3)
			last | grep ppp | grep still | awk '{print "        ┃",$1,"" }' >/tmp/login-db-pptp.txt
			#printf "%-5s %-15s %-15s %-15s\n" "" "$username" "$Local" "" > /tmp/login-db-pptp.txt;
			clear
			cr
			echo "        ╭━━━━━━━━━━━━━━━━━━━╮ 
        ┃ PPTP VPN User Login 
        ╰━━━━━┳━━━━━━━━━━━━━╯
        ╭━━━━━┻━━━━━━╮ 
        ┃ UserName       
        ┃  "
			cat /tmp/login-db-pptp.txt
			echo "        ╰━━━━━━━━━━━━╯
"
			exit
			;;
		4)

			chmod +x /var/lib/premium-script/data-user-pptp
			clear
			cr
			echo "       ╭━━━━━━━━━━━━━━━━━━━━━━━━━╮"
			read -p "       ╰┫Username : " username
			grep -E "^$username" /var/lib/premium-script/data-user-pptp >/dev/null
			if [ $? -eq 0 ]; then
				userpass=$(cat /var/lib/premium-script/data-user-pptp | grep "^$username" | awk '{print $3}')
				saat_expired=$(cat /var/lib/premium-script/data-user-pptp | grep "^$username" | awk '{print $5}')
				tanggal_expired=$(date -u --date="1970-01-01 $saat_expired sec GMT" +%Y/%m/%d)
				tanggal_expired_display=$(date -u --date="1970-01-01 $saat_expired sec GMT" '+%d %B %Y')
				clear
				cr
				echo "       ╭━━━━━━━━━━━━━━━━━━━━━━━━━╮
       ┃  รายละเอียดบันชี  $username 
       ┣━━━━━━━━━━━━━━━━━━━━━╯ 
       ┣ ชื่อผู้ใช้   : $username         
       ┣ รหัสผ่าน  : $userpass            
       ┣ หมดอายุ  : $tanggal_expired_display   
       ┣━━━━━━━━━━━━━━━━━━━━━━━━━╯ 
       ╰━━┫ http://www.smile-vpn.net   
"
				exit
			else
				echo "        ╭━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ ไม่พบชื่อผู้ใช้  $username 
        ╰━━━━━━━━━━━━━━━━━━━━━━╯ 
"
				exit 1
			fi
			;;
		5)
			clear
			cr
			echo "echo "Script Created By smilevpn"" >/usr/local/bin/infouser-pptp
			echo "echo "Script Created By smilevpn"" >/usr/local/bin/expireduser-pptp
			chmod +x /usr/local/bin/infouser-pptp
			chmod +x /usr/local/bin/expireduser
			chmod +x /etc/ppp/chap-secrets
			chmod +x /var/lib/premium-script/data-user-pptp

			totalaccounts=$(cat /var/lib/premium-script/data-user-pptp | wc -l)
			for ((i = 1; i <= $totalaccounts; i++)); do
				username=$(cat /var/lib/premium-script/data-user-pptp | awk '{print $1}' | head -n $i | tail -n 1)
				userexpireinseconds=$(cat /var/lib/premium-script/data-user-pptp | awk '{print $5}' | head -n $i | tail -n 1)
				tglexp=$(date -d @$userexpireinseconds)
				tgl=$(echo $tglexp | awk -F" " '{print $3}')
				bulantahun=$(echo $tglexp | awk -F" " '{print $2,$6}')
				todaystime=$(date +%s)
				seeder=s/^$username/#$username/g
				if [ $userexpireinseconds -ge $todaystime ]; then
					timeto7days=$(($todaystime + 604800))
					if [ $userexpireinseconds -le $timeto7days ]; then
						echo "echo "User : $username will expired on : $tgl $bulantahun"" >>/usr/local/bin/infouser-pptp
					fi
				else
					echo "echo "User : $username expired on date : $tgl $bulantahun"" >>/usr/local/bin/expireduser-pptp
					sed -i $seeder /var/lib/premium-script/data-user-pptp
					sed -i $seeder /etc/ppp/chap-secrets
					sed -i "s|##|#|g" /etc/ppp/chap-secrets
					sed -i "s|###|#|g" /etc/ppp/chap-secrets
					sed -i "s|####|#|g" /etc/ppp/chap-secrets
					sed -i "s|#####|#|g" /etc/ppp/chap-secrets
					sed -i "s|######|#|g" /etc/ppp/chap-secrets
					sed -i "s|#######|#|g" /etc/ppp/chap-secrets
					sed -i "s|########|#|g" /etc/ppp/chap-secrets
					sed -i "s|#########|#|g" /etc/ppp/chap-secrets
					sed -i "s|##########|#|g" /etc/ppp/chap-secrets
					sed -i "s|###########|#|g" /etc/ppp/chap-secrets
					sed -i "s|############|#|g" /etc/ppp/chap-secrets
					sed -i "s|#############|#|g" /etc/ppp/chap-secrets
					sed -i "s|##############|#|g" /etc/ppp/chap-secrets
					sed -i "s|###############|#|g" /etc/ppp/chap-secrets
					sed -i "s|################|#|g" /etc/ppp/chap-secrets
					sed -i "s|#################|#|g" /etc/ppp/chap-secrets
					sed -i "s|##|#|g" /var/lib/premium-script/data-user-pptp
					sed -i "s|###|#|g" /var/lib/premium-script/data-user-pptp
					sed -i "s|####|#|g" /var/lib/premium-script/data-user-pptp
					sed -i "s|#####|#|g" /var/lib/premium-script/data-user-pptp
					sed -i "s|######|#|g" /var/lib/premium-script/data-user-pptp
					sed -i "s|#######|#|g" /var/lib/premium-script/data-user-pptp
					sed -i "s|########|#|g" /var/lib/premium-script/data-user-pptp
					sed -i "s|#########|#|g" /var/lib/premium-script/data-user-pptp
					sed -i "s|##########|#|g" /var/lib/premium-script/data-user-pptp
					sed -i "s|###########|#|g" /var/lib/premium-script/data-user-pptp
					sed -i "s|############|#|g" /var/lib/premium-script/data-user-pptp
					sed -i "s|#############|#|g" /var/lib/premium-script/data-user-pptp
					sed -i "s|##############|#|g" /var/lib/premium-script/data-user-pptp
					sed -i "s|###############|#|g" /var/lib/premium-script/data-user-pptp
					sed -i "s|################|#|g" /var/lib/premium-script/data-user-pptp
					sed -i "s|#################|#|g" /var/lib/premium-script/data-user-pptp
				fi
			done
			clear
			cr
			echo "           ╭━━━━━━━━━━━━━━━━╮  
           ┣ ไม่รู้ว่ะ กูงงกับเมนูนี้   
           ╰━━━━━━━━━━━━━━━━╯  
  "
			exit
			;;
		6)
			totalaccounts=$(cat /var/lib/premium-script/data-user-pptp | wc -l)
			echo " " >/tmp/alluser-pptp-data
			for ((i = 1; i <= $totalaccounts; i++)); do

				username=$(cat /var/lib/premium-script/data-user-pptp | awk '{print $1}' | head -n $i | tail -n 1)
				userpass=$(cat /var/lib/premium-script/data-user-pptp | awk '{print $3}' | head -n $i | tail -n 1)
				saat_expired=$(cat /var/lib/premium-script/data-user-pptp | awk '{print $5}' | head -n $i | tail -n 1)
				tanggal_expired=$(date -u --date="1970-01-01 $saat_expired sec GMT" +%Y/%m/%d)
				tanggal_expired_display=$(date -u --date="1970-01-01 $saat_expired sec GMT" '+%d %B %Y')
				printf "%-2s %-15s %-15s %-15s\n" "" "$username" "$userpass" "$tanggal_expired_display" >>/tmp/alluser-pptp-data
				#echo "   $username  ┈  $userpass  ┈  $tanggal_expired_display " >> /tmp/alluser-pptp-data
			done
			clear
			cr
			echo " ╭━━━━┻━━━━━━━━━━━━━╮    "
			echo " ┣ VPN PPTP Accounts    "
			echo " ╰━━┳━━━━━━━━━━━┳━━━╯    "
			echo " ╭━━┻━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮   "
			printf "%-2s %-15s %-15s %-15s\n" "" "username" "Password" "Expired_display"
			cat /tmp/alluser-pptp-data
			echo " ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯  
  "
			exit
			;;
		7)
			clear
			cr
			echo ""
			service pptpd restart
			exit
			;;
		8)
			ok ""
			red " แน่ใจว่าต้องการถอนติดตั้ง PPTP  Y/n   "
			ok ""
			read -p " : " selet

			if [[ "$selet" = "y" || "$selet" = "Y" ]]; then
				rm -r -f /etc/pptpd
				apt-get -y --purge remove pptpd
				clear
				cr
				echo "        ╭━━━━━━━━━━━━━━━━━━━━╮    "
				echo "        ┣ ถอนติดตั้ง PPTP เรียบร้อย    "
				echo "        ╰━━━━━━━━━━━━━━━━━━━━╯    "
				exit
			elif [[ "$selet" = "n" || "$selet" = "N" ]]; then
				clear
				cr
				echo "          ╭━━━━━━━━━━━━━━━━━━╮    "
				echo "          ┣ ยกเลิกถอนติดตั้ง PPTP    "
				echo "          ╰━━━━━━━━━━━━━━━━━━╯    "
				exit
			fi
			;;

		esac
		clear
		cr
		echo "           ╭━━━━━━━━━━━━━━━━╮    "
		echo "           ┣ คุณใช้คำสั่งผิดพลาด    "
		echo "           ╰━━━━━━━━━━━━━━━━╯    "
		exit
		;;
	26)
		clear
		echo "
 ========================
  ใส่ชื่อผู้ใช้ที่ต้องการตรวจสอบ
 ========================
"
		read -p " Username : " user
		if getent passwd $user; then
			printf ""
		else
			echo " "
			echo -e "\033[01;31m === ไม่มีผู้ใช้ อาจจะหมดอายุไปแล้ว ก่อนหน้านี้ ===  "
			echo -e "\033[01;36m "
			exit
		fi
		datahoje=$(date +%s)
		dataexp=$(chage -l $user | grep "Account expires" | awk -F : '{print $2}')
		if [[ $dataexp == ' never' ]]; then
			id >/dev/null 2>/dev/null
		else
			dataexpn=$(date -d"$dataexp" '+%d/%m/%Y')
			dataexpnum=$(date '+%s' -d"$dataexp")
		fi
		if [[ $dataexpnum < $datahoje ]]; then
			if [[ $1 == "" ]]; then
				clear
				echo -e "\033[01;35m
 ===================================
  $user หมดอายุแล้ว เมื่อวันที่ $dataexpn
 ==================================="
				echo -e "
 ต้องการต่ออายุหรือไม่ "
				read -p " Y/n : " opcao
			else
				opcao=$1
			fi
			case $opcao in
			y | Y)
				clear
				echo -e "\033[01;35m"
				echo " ============================
  จะต่ออายุให้กับ $user อีกกี่วัน ..?
 ============================"
				echo -e "\033[01;33m"
				read -p " Enter Day : " exp
				expire=$(date -d "$exp days" +"%Y-%m-%d")
				chage -E $expire $user 2>/dev/null
				clear
				expp=$(date -d "$exp days" +"%d-%m-%Y")
				echo -e "\033[01;35m
 ======================================
  $user ต่ออายุเรียบร้อย ใช้ได้ถึ่งวันที่ $expp
 ======================================
"
				echo -e "\033[1;33m"
				exit
				;;
			n | N)
				echo -e "\033[1;31m"
				echo " ลบผู้ใช้เรียบร้อย"
				echo -e "\033[1;33m"
				kill $(ps -u $user | awk '{print $1}') >/dev/null 2>/dev/null
				userdel $user
				exit
				;;
			esac
			echo " "
			echo -e "\033[01;31m === ไม่มีตัวเลือกที่ตรงกัน ===  "
		else
			clear
			echo -e "\033[1;35m
 ==============================="
			printf "\033[1;35m"
			printf '%-2s'
			printf "$user"
			printf "  หมดอายุวันที่  "
			echo $dataexpn
			echo " ==============================="
		fi
		echo -e "\033[1;33m"
		exit
		;;
	27)

		clear
		cr
		echo "       ╭━━━━━━━━━━╮"
		echo "       ┣ 》1: TRUE         "
		echo "       ┣ 》2: DTAC           "
		echo "       ┣━━━━━━━━━━╯"
		read -p "       ┣ Namber : " smile

		if [[ "$smile" = "1" ]]; then
			grep -E "^proto tcp" /etc/openvpn/1194.conf >/dev/null
			if [ $? -eq 0 ]; then
				read -p "       ┣ Host/IP    : " -e -i $IP Host
				read -p "       ┣ ใส่เพโหลด  : " payload
			else
				read -p "       ┣ Host/IP    : " -e -i $IP Host
			fi
			read -p "       ╰ ต้องการบันทึกหรือไม่ y/n  : " Edit
			if [[ "$Edit" = "y" || "$Edit" = "Y" ]]; then
				grep -E "^proto tcp" /etc/openvpn/1194.conf >/dev/null
				if [ $? -eq 0 ]; then
					proto="proto tcp"
					proxy="http-proxy $Host 8080"
					remote="remote $Host:1194@$payload 1194"

				else
					proto="proto udp"
					remote="remote $Host 1194"
				fi

				cat >/etc/openvpn/true.ovpn <<SMILE
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
SMILE
				grep -E "^port 1194" /etc/openvpn/1194.conf >/dev/null
				if [ $? -eq 0 ]; then
					echo
				else
					sed -i 's/1194/443/g' /etc/openvpn/true.ovpn
				fi

				clear
				cr
				echo "      ╭━━━━━━━━━━━━╮
      ┣ บันทึกเรียบร้อย
      ╰━━━━━━━━━━━━╯
   "
				exit
			elif [[ "$Edit" = "n" || "$Edit" = "N" ]]; then
				echo "      ╭━━━━━━━━━━━━╮
      ┣ ยกเลิกการบันทึก
      ╰━━━━━━━━━━━━╯
   "
				exit
			fi

		elif [[ "$smile" = "2" ]]; then
			grep -E "^proto tcp" /etc/openvpn/1194.conf >/dev/null
			if [ $? -eq 0 ]; then
				read -p "       ┣ Host/IP    : " -e -i $IP Host
				read -p "       ┣ ใส่เพโหลด  : " payload
			else
				read -p "       ┣ Host/IP    : " -e -i $IP Host
			fi
			read -p "       ╰ ต้องการบันทึกหรือไม่ y/n  : " Edit
			if [[ "$Edit" = "y" || "$Edit" = "Y" ]]; then
				grep -E "^proto tcp" /etc/openvpn/1194.conf >/dev/null
				if [ $? -eq 0 ]; then
					proto="proto tcp"
					proxy="http-proxy $Host 8080"
					remote="remote $Host:1194@$payload 1194"
					remote1="remote Scrip_350 999 udp"

				else
					proto="proto udp"
					remote="remote $Host 1194"
				fi

				cat >/etc/openvpn/dtac.ovpn <<SMILE
client
dev tun
$proto
$remote1
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

SMILE
				grep -E "^port 1194" /etc/openvpn/1194.conf >/dev/null
				if [ $? -eq 0 ]; then
					echo
				else
					sed -i 's/1194/443/g' /etc/openvpn/dtac.ovpn
				fi

				clear
				cr
				echo "      ╭━━━━━━━━━━━━╮
      ┣ บันทึกเรียบร้อย
      ╰━━━━━━━━━━━━╯
   "
				exit
			elif [[ "$Edit" = "n" || "$Edit" = "N" ]]; then
				echo "      ╭━━━━━━━━━━━━╮
      ┣ ยกเลิกการบันทึก
      ╰━━━━━━━━━━━━╯
   "
				exit
			fi
			if [[ "$smile" = "" ]]; then
				echo "      ╭━━━━━━━━━━╮
      ┣ ไม่พบข้อมูล
      ╰━━━━━━━━━━╯
   "
				exit
			fi
			exit
		fi
		;;
	28)
		#!/bin/bash
		# Functions
		if [ -e '/etc/squid3/squid.conf' ]; then
			if [ -e '/etc/squid3/squid.txt' ]; then
				echo ""
				clear
			else
				echo "" >/etc/squid3/squid.txt
				sed -i '/^$/d' /etc/squid3/squid.txt
			fi
		else
			if [ -e '/etc/squid/squid.txt' ]; then
				echo ""
				clear
			else
				echo "" >/etc/squid/squid.txt
				sed -i '/^$/d' /etc/squid/squid.txt
			fi
		fi

		if [ -e '/etc/squid3/squid.conf' ]; then
			if [ -e '/etc/squid3/port.txt' ]; then
				echo ""
				clear
			else
				echo " ┣ http_port 8080  " >/etc/squid3/port.txt
				sed -i '/^$/d' /etc/squid3/squid.txt
			fi
		else
			if [ -e '/etc/squid/port.txt' ]; then
				echo ""
				clear
			else
				echo " ┣ http_port 8080  " >/etc/squid/port.txt
				sed -i '/^$/d' /etc/squid/squid.txt
			fi
		fi

		clear
		cr
		echo " ╭━━━━━━━━━━━╮ 
 ┣ การตั้งค่า Proxy
 ┣━━━━━━━━━━━╯
 ┣ 1. เปิดปิดใช้งานไม่จำกัด IP
 ┣ 2. ตั้งค่าไอพี 
 ┣ 3. ตั้งค่าพอร์ต  "
		read -p " ╰━━┫พิมพ์ตัวเลข  : " smile

		if [[ "$smile" = "" ]]; then
			clear
			cr
			echo " ╭━━━━━━━━━━━╮ 
 ┣ โปรดพิมพ์คำสั่ง
 ╰━━━━━━━━━━━╯ 
 "
			exit
		fi
		if [[ "1" = "$smile" ]]; then
			if [ -e '/etc/squid3/squid.conf' ]; then
				grep -E "^http_access allow all" /etc/squid3/squid.conf >/dev/null
			else
				grep -E "^http_access allow all" /etc/squid/squid.conf >/dev/null
			fi
			if [ $? -eq 0 ]; then
				clear
				cr
				echo " ╭━━━━━━━━━━━━━━━━━━━━━━━━━━╮
 ┣ สถานะปัจจุบัน Proxy ไม่จำกัด IP
 ┣━━━━━━━━━━━━━━━━━━━━━━━━━━╯ "
				read -p " ┣ เปลี่ยนเป็น Proxy ใช้ใด้เฉพาะเซิฟร์นี้หรือไม่ Y/n :" selet
				if [[ "$selet" = "Y" || "$selet" = "y" ]]; then
					if [ -e '/etc/squid3/squid.conf' ]; then
						sed -i "s/http_access allow all/http_access allow localhost/g" /etc/squid3/squid.conf
						echo " ╰ กำลังเปิดใช้งานตั้งค่าใหม่ รอสัครู่..."
						service squid3 restart
					else
						sed -i "s/http_access allow all/http_access allow localhost/g" /etc/squid/squid.conf
						echo " ╰ กำลังเปิดใช้งานตั้งค่าใหม่ รอสัครู่..."
						service squid restart
					fi
					clear
					cr
					echo " ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
 ┣ สถานะปัจจุบัน Proxy ใช้ใด้เฉพาะเซิฟร์นี้
 ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━╯
 "
					exit
				fi
				clear
				cr
				echo " ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
 ┣ สถานะเปลี่ยนเป็น Proxy ไม่จำกัด IP
 ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━╯ 
"
				exit
			else
				clear
				cr
				echo "
 ╭━━━━━━━━━━━━━━━━━━━━━━━━━╮
 ┣ สถานะปัจจุบัน Proxy ใช้ใด้เฉพาะเซิฟร์นี้
 ┣━━━━━━━━━━━━━━━━━━━━━━━━━╯ "
				read -p " ┣ เปลี่ยนเป็น Proxy ไม่จำกัด IP หรือไม่ Y/n :" selet
				if [[ "$selet" = "Y" || "$selet" = "y" ]]; then
					if [ -e '/etc/squid3/squid.conf' ]; then
						sed -i "s/http_access allow localhost/http_access allow all/g" /etc/squid3/squid.conf
						echo " ╰ กำลังเปิดใช้งานตั้งค่าใหม่ รอสัครู่..."
						service squid3 restart
					else
						sed -i "s/http_access allow localhost/http_access allow all/g" /etc/squid/squid.conf
						echo " ╰ กำลังเปิดใช้งานตั้งค่าใหม่ รอสัครู่..."
						service squid restart
					fi
					clear
					cr
					echo " ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
 ┣ สถานะเปลี่ยนเป็น Proxy ใช้ใด้หลาย IP
 ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━╯ 
"

					exit
				fi
				clear
				cr
				echo " ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
 ┣ สถานะปัจจุบัน Proxy ใช้ใด้เฉพาะเซิฟร์นี้
 ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━╯               
 "
				exit
			fi
		elif [[ "2" = "$smile" ]]; then
			clear
			cr
			echo " ╭━━━━━━━━━━━━╮ 
 ┣ เลือกใช้คำสั่ง
 ┣━━━━━━━━━━━━╯     
 ┣ 1. เพิ่มไอพี
 ┣ 2. เช็ดไอพี
 ┣ 3. ลบไอพี          "
			read -p " ┣ พิมพ์ตัวเลข : " Selet
			if [[ "$Selet" = "" ]]; then
				clear
				cr
				echo " ╭━━━━━━━━━━━╮ 
 ┣ โปรดพิมพ์คำสั่ง
 ╰━━━━━━━━━━━╯ 
 "
				exit
			fi
			if [[ $Selet = 1 ]]; then
				read -p " ┣ ใส่เลขไอพีที่จะใช้งานพร็อกซี่นี้ : " SERVER_IP
				if [ -e '/etc/squid3/squid.conf' ]; then
					grep -E "^acl SSH dst $SERVER_IP" /etc/squid3/squid.conf >/dev/null
				else
					grep -E "^acl SSH dst $SERVER_IP" /etc/squid/squid.conf >/dev/null
				fi
				if [ $? -eq 0 ]; then
					clear
					cr
					echo " ╭━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
 ┣ IP $SERVER_IP มีอยู่ในระบบแล้ว
 ╰━━━━━━━━━━━━━━━━━━━━━━━━━━╯               
 "
					exit
				else
					read -p " ┣ บันทึกการตั้งค่านี้หรือไม่ y/n : " YN
				fi
				if [[ n = $YN || N = $YN ]]; then
					clear
					cr
					echo " ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
 ┣ $SERVER_IP ไม่ได้ยืนยันการใช้งาน
 ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯               
 "
					exit
				fi

				if [ -e '/etc/squid3/squid.conf' ]; then
					sed -i "/acl CONNECT method CONNECT/a acl SSH dst xxxxxxxxxx-xxxxxxxxxx\/255.255.255.255" /etc/squid3/squid.conf
					sed -i "s/xxxxxxxxxx/$SERVER_IP/g" /etc/squid3/squid.conf
					echo " ┣ $SERVER_IP " >>/etc/squid3/squid.txt
					echo " ╰ กำลังเปิดใช้งานตั้งค่าใหม่ รอสัครู่..."
					service squid3 restart
				else
					sed -i "/acl CONNECT method CONNECT/a acl SSH dst xxxxxxxxxx-xxxxxxxxxx\/255.255.255.255" /etc/squid/squid.conf
					sed -i "s/xxxxxxxxxx/$SERVER_IP/g" /etc/squid/squid.conf
					echo " ┣ $SERVER_IP " >>/etc/squid/squid.txt
					echo " ╰ กำลังเปิดใช้งานตั้งค่าใหม่ รอสัครู่..."
					service squid restart
				fi
				clear
				cr
				echo " ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
 ┣ $SERVER_IP ใช้งานพร็อกซี่เซิฟร์นี้เรียบร้อย
 ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯               
 "
				exit
			elif [[ $Selet = 2 ]]; then
				if [ -e '/etc/squid3/squid.conf' ]; then
					grep -E "^http_access allow all" /etc/squid3/squid.conf >/dev/null
				else
					grep -E "^http_access allow all" /etc/squid/squid.conf >/dev/null
				fi
				if [ $? -eq 0 ]; then
					clear
					cr
					echo " ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
 ┣ สถานะปัจจุบัน Proxy ไม่จำกัด IP
 ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━╯ 
"
					exit
				else

					clear
					cr
					echo " ╭━━━━━━━━━━━━━━━━━━━╮ 
 ┣ ไอพีที่เปิดใช้งานอยู่ปัจจุบัน
 ┣━━━━━━━━━━━━━━━━━━━╯                "
					echo " ┣ $IP  "
					if [ -e '/etc/squid3/squid.conf' ]; then
						cat /etc/squid3/squid.txt
						echo " ╰━━━━━━━━━━━━━━━━━━━╯
"
					else
						cat /etc/squid/squid.txt
						echo " ╰━━━━━━━━━━━━━━━━━━━╯
"
					fi
					exit
				fi
			elif [[ $Selet = 3 ]]; then
				clear
				cr
				echo " ╭━━━━━━━━━━━╮ 
 ┣ ลบไอพีพร็อกซี่
 ┣━━━━━━━━━━━╯   "
				echo " ┣ 1. ลบบางไอพี  "
				echo " ┣ 2. รีเซ็ตค่าเดิม  "
				read -p " ┣ พิมพ์ตัวเลข : " Selet1
				if [[ $Selet1 = 1 ]]; then
					read -p " ┣ ใส่เลขไอพีที่จะลบ : " SERVER_IP
					if [ -e '/etc/squid3/squid.conf' ]; then
						grep -E "^acl SSH dst $SERVER_IP" /etc/squid3/squid.conf >/dev/null
					else
						grep -E "^acl SSH dst $SERVER_IP" /etc/squid/squid.conf >/dev/null
					fi

					if [ $? -eq 0 ]; then
						if [[ $SERVER_IP = $IP ]]; then
							clear
							cr
							echo " ╭━━━━━━━━━━━━━━━━━━━━━╮ 
 ┣ ไม่อณุญาตให้ลบไอพีของเซิฟร์นี้
 ╰━━━━━━━━━━━━━━━━━━━━━╯               
 "
							exit
						fi
						read -p " ┣ แน่ใจว่าต้องการลบไอพี Y/n : " YN
					else
						clear
						cr
						echo " ╭━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
 ┣ ไม่พบ IP $SERVER_IP ในระบบ
 ╰━━━━━━━━━━━━━━━━━━━━━━━━━━╯               
 "
						exit
					fi

					if [[ $YN = N || $YN = n ]]; then
						clear
						cr
						echo " ╭━━━━━━━━━━━━━━━━━━━━━╮ 
 ┣ ยกเลิกการเปลียนแปลง
 ╰━━━━━━━━━━━━━━━━━━━━━╯               
 "
						exit
					fi

					if [ -e '/etc/squid3/squid.conf' ]; then
						SERVER_IP2="/$SERVER_IP/d"
						sed -i $SERVER_IP2 /etc/squid3/squid.txt
						sed -i $SERVER_IP2 /etc/squid3/squid.conf
						sed -i '/^$/d' /etc/squid3/squid.txt
						sed -i '/^$/d' /etc/squid3/squid.conf
						echo " ╰ กำลังเปิดใช้งานตั้งค่าใหม่ รอสัครู่..."
						service squid3 restart
					else
						SERVER_IP2="/$SERVER_IP/d"
						sed -i $SERVER_IP2 /etc/squid/squid.txt
						sed -i $SERVER_IP2 /etc/squid/squid.conf
						sed -i '/^$/d' /etc/squid/squid.txt
						sed -i '/^$/d' /etc/squid/squid.conf
						echo " ╰ กำลังเปิดใช้งานตั้งค่าใหม่ รอสัครู่..."
						service squid restart
					fi
					clear
					cr
					echo " ╭━━━━━━━━━━━━━━━━━━━━━╮ 
 ┣ ลบไอพี $SERVER_IP เรียบร้อย
 ╰━━━━━━━━━━━━━━━━━━━━━╯               
 "
					exit
				elif [[ $Selet1 = 2 ]]; then
					read -p " ┣ แน่ใจว่าต้องการลบไอพีทั้งหมด Y/n : " YN
					if [[ $YN = N || $YN = n ]]; then
						clear
						cr
						echo " ╭━━━━━━━━━━━━━━━━━━━━━╮ 
 ┣ ยกเลิกการเปลียนแปลง
 ╰━━━━━━━━━━━━━━━━━━━━━╯               
 "
						exit
					fi
					if [ -e '/etc/squid3/squid.conf' ]; then
						SERVER_IP2="/255.255.255.255/d"
						sed -i $SERVER_IP2 /etc/squid3/squid.txt
						sed -i $SERVER_IP2 /etc/squid3/squid.conf
						sed -i '/^$/d' /etc/squid3/squid.txt
						sed -i '/^$/d' /etc/squid3/squid.conf
						sed -i "/acl CONNECT method CONNECT/a acl SSH dst xxxxxxxxxx-xxxxxxxxxx\/255.255.255.255" /etc/squid3/squid.conf
						sed -i "s/xxxxxxxxxx/$IP/g" /etc/squid3/squid.conf
						echo "" >/etc/squid3/squid.txt
						sed -i '/^$/d' /etc/squid3/squid.txt
						echo " ╰ กำลังเปิดใช้งานตั้งค่าใหม่ รอสัครู่... "
						service squid3 restart
					else
						SERVER_IP2="/255.255.255.255/d"
						sed -i $SERVER_IP2 /etc/squid/squid.txt
						sed -i $SERVER_IP2 /etc/squid/squid.conf
						sed -i '/^$/d' /etc/squid/squid.conf
						sed -i "/acl CONNECT method CONNECT/a acl SSH dst xxxxxxxxxx-xxxxxxxxxx\/255.255.255.255" /etc/squid/squid.conf
						sed -i "s/xxxxxxxxxx/$IP/g" /etc/squid/squid.conf
						echo "" >/etc/squid/squid.txt
						sed -i '/^$/d' /etc/squid/squid.txt
						echo " ╰ กำลังเปิดใช้งานตั้งค่าใหม่ รอสัครู่... "
						service squid restart
					fi
					clear
					cr
					echo " ╭━━━━━━━━━━━━━━━━━━╮ 
 ┣ ลบไอพีทั้งหมด เรียบร้อย
 ╰━━━━━━━━━━━━━━━━━━╯               
 "
					exit
				fi
			fi
		elif [[ "3" = "$smile" ]]; then
			clear
			cr
			echo " ╭━━━━━━━━━━━━╮ 
 ┣ เลือกใช้คำสั่ง
 ┣━━━━━━━━━━━━╯     
 ┣ 1. เพิ่มพอร์ต
 ┣ 2. เช็ดพอร์ต
 ┣ 3. ลบพอร์ต          "
			read -p " ┣ พิมพ์ตัวเลข : " Selet
			if [[ "$Selet" = "" ]]; then
				clear
				cr
				echo " ╭━━━━━━━━━━━╮ 
 ┣ โปรดพิมพ์คำสั่ง
 ╰━━━━━━━━━━━╯ 
 "
				exit
			fi
			if [[ $Selet = 1 ]]; then
				read -p " ┣ ใส่พอร์ตที่จะใช้งานกับพร็อกซี่ : " Port
				if [ -e '/etc/squid3/squid.conf' ]; then
					grep -E "^http_port $Port" /etc/squid3/squid.conf >/dev/null
				else
					grep -E "^http_port $Port" /etc/squid/squid.conf >/dev/null
				fi

				if [ $? -eq 0 ]; then
					clear
					cr
					echo " ╭━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
 ┣ Port $Port มีอยู่ในระบบแล้ว
 ╰━━━━━━━━━━━━━━━━━━━━━━━━━━╯               
 "
					exit
				else
					if [[ $Port = 80 || $Port = 443 || $Port = 22 || $Port = 143 || $Port = 444 || $Port = 10000 || $Port = 4468 || $Port = 9000 || $Port = 1 || $Port = 2 || $Port = 3 || $Port = 4 || $Port = 5 || $Port = 6 || $Port = 7 || $Port = 8 || $Port = 9 || $Port = 0 || $Port = 21 || $Port = 70 || $Port = 210 || $Port = 1025 || $Port = 65535 || $Port = 280 || $Port = 488 || $Port = 591 || $Port = 777 || $Port = 255 || $Port = 10 || $Port = 172 || $Port = 127 || $Port = 192 || $Port = 32 || $Port = 12 || $Port = 16 || $Port = 1440 || $Port = 20 || $Port = 10080 || $Port = 4320 || $Port = 3128 || $Port = 5555 ]]; then
						clear
						cr
						echo " ╭━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
 ┣ Port $Port ไม่สามารถเปิดใช้งานได้
 ╰━━━━━━━━━━━━━━━━━━━━━━━━━━╯               
 "
						exit
					fi
					read -p " ┣ บันทึกการตั้งค่านี้หรือไม่ y/n : " YN
				fi
				if [[ n = $YN || N = $YN ]]; then
					clear
					cr
					echo " ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
 ┣ $Port ไม่ได้ยืนยันการใช้งาน
 ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯               
 "
					exit
				fi

				if [ -e '/etc/squid3/squid.conf' ]; then
					sed -i "/http_port 8080/a http_port xxxx" /etc/squid3/squid.conf
					sed -i "s/xxxx/$Port/g" /etc/squid3/squid.conf
					echo " ┣ http_port $Port " >>/etc/squid3/port.txt
					echo " ╰ กำลังเปิดใช้งานตั้งค่าใหม่ รอสัครู่..."
					service squid3 restart
				else
					sed -i "/http_port 8080/a http_port xxxx" /etc/squid/squid.conf
					sed -i "s/xxxx/$Port/g" /etc/squid/squid.conf
					echo " ┣ http_port $Port  " >>/etc/squid/port.txt
					echo " ╰ กำลังเปิดใช้งานตั้งค่าใหม่ รอสัครู่..."
					service squid restart
				fi
				clear
				cr
				echo " ╭━━━━━━━━━━━━━━━━━━━━━╮ 
 ┣ Port $Port พร้อมใช้งาน
 ╰━━━━━━━━━━━━━━━━━━━━━╯               
 "
				exit
			elif [[ $Selet = 2 ]]; then

				clear
				cr
				echo " ╭━━━━━━━━━━━━━━━━━━━╮ 
 ┣ พอร์ตที่เปิดใช้งานอยู่ปัจจุบัน
 ┣━━━━━━━━━━━━━━━━━━━╯                "
				if [ -e '/etc/squid3/squid.conf' ]; then
					cat /etc/squid3/port.txt
					echo " ╰━━━━━━━━━━━━━━━━━━━╯
"
				else
					cat /etc/squid/port.txt
					echo " ╰━━━━━━━━━━━━━━━━━━━╯
"
					exit
				fi

			elif [[ $Selet = 3 ]]; then
				clear
				cr
				echo " ╭━━━━━━━━━━━╮ 
 ┣ ลบพอร์ตพร็อกซี่
 ┣━━━━━━━━━━━╯   "
				echo " ┣ 1. ลบบางพอร์ต  "
				echo " ┣ 2. รีเซ็ตค่าเดิม  "
				read -p " ┣ พิมพ์ตัวเลข : " Selet1
				if [[ $Selet1 = 1 ]]; then
					read -p " ┣ ใส่เลขพอร์ตที่จะลบ : " Port
					if [ -e '/etc/squid3/squid.conf' ]; then
						grep -E "^http_port $Port" /etc/squid3/squid.conf >/dev/null
					else
						grep -E "^http_port $Port" /etc/squid/squid.conf >/dev/null
					fi
					if [ $? -eq 0 ]; then
						if [[ $Port = 8080 ]]; then
							clear
							cr
							echo " ╭━━━━━━━━━━━━━━━━━━━━━╮ 
 ┣ ไม่อณุญาตให้ลบพอร์ต 8080
 ╰━━━━━━━━━━━━━━━━━━━━━╯               
 "
							exit
						fi
						read -p " ┣ แน่ใจว่าต้องการลบพอร์ต Y/n : " YN
					else
						clear
						cr
						echo " ╭━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
 ┣ ไม่พบ Port $Port ในระบบ
 ╰━━━━━━━━━━━━━━━━━━━━━━━━━━╯               
 "
						exit
					fi

					if [[ $YN = N || $YN = n ]]; then
						clear
						cr
						echo " ╭━━━━━━━━━━━━━━━━━━━━━╮ 
 ┣ ยกเลิกการเปลียนแปลง
 ╰━━━━━━━━━━━━━━━━━━━━━╯               
 "
						exit
					fi

					if [ -e '/etc/squid3/squid.conf' ]; then
						SERVER_IP2="/$Port/d"
						sed -i $SERVER_IP2 /etc/squid3/port.txt
						sed -i $SERVER_IP2 /etc/squid3/squid.conf
						sed -i '/^$/d' /etc/squid3/port.txt
						sed -i '/^$/d' /etc/squid3/squid.conf
						echo " ╰ กำลังเปิดใช้งานตั้งค่าใหม่ รอสัครู่..."
						service squid3 restart
					else
						SERVER_IP2="/$Port/d"
						sed -i $SERVER_IP2 /etc/squid/port.txt
						sed -i $SERVER_IP2 /etc/squid/squid.conf
						sed -i '/^$/d' /etc/squid/port.txt
						sed -i '/^$/d' /etc/squid/squid.conf
						echo " ╰ กำลังเปิดใช้งานตั้งค่าใหม่ รอสัครู่... "
						service squid restart
					fi
					clear
					cr
					echo " ╭━━━━━━━━━━━━━━━━━━━━━╮ 
 ┣ ลบพอร์ต $Port เรียบร้อย
 ╰━━━━━━━━━━━━━━━━━━━━━╯               
 "
					exit
				elif [[ $Selet1 = 2 ]]; then
					read -p " ┣ แน่ใจว่าต้องรีเซ็ตค่าเดิม Y/n : " YN
					if [[ $YN = N || $YN = n ]]; then
						clear
						cr
						echo "      ╭━━━━━━━━━━━━━━╮ 
      ┣ ยกเลิกการรีเซ็ต
      ╰━━━━━━━━━━━━━━╯               
 "
						exit
					fi
					if [ -e '/etc/squid3/squid.conf' ]; then
						SERVER_IP2="/http_port/d"
						sed -i $SERVER_IP2 /etc/squid3/port.txt
						sed -i $SERVER_IP2 /etc/squid3/squid.conf
						sed -i '/^$/d' /etc/squid3/port.txt
						sed -i '/^$/d' /etc/squid3/squid.conf
						sed -i "/http_access allow SSH/a http_port 8080" /etc/squid3/squid.conf
						echo " ┣ http_port 8080 " >/etc/squid3/port.txt
						sed -i '/^$/d' /etc/squid3/port.txt
						echo " ╰ กำลังเปิดใช้งานตั้งค่าใหม่ รอสัครู่... "
						service squid3 restart
					else
						SERVER_IP2="/http_port/d"
						sed -i $SERVER_IP2 /etc/squid/port.txt
						sed -i $SERVER_IP2 /etc/squid/squid.conf
						sed -i '/^$/d' /etc/squid/squid.conf
						sed -i "/http_access allow SSH/a http_port 8080" /etc/squid/squid.conf
						echo " ┣ http_port 8080 " >/etc/squid/port.txt
						sed -i '/^$/d' /etc/squid/port.txt
						echo " ╰ กำลังเปิดใช้งานตั้งค่าใหม่ รอสัครู่... "
						service squid restart
					fi
					clear
					cr
					echo "         ╭━━━━━━━━━━━━━━━━━━╮ 
         ┣ รีเซ็ตพอร์ค่าเดิมเรียบร้อย
         ╰━━━━━━━━━━━━━━━━━━╯               
 "
					exit
				fi
			fi
		fi
		exit
		;;
	29)
		#!/bin/bash
		if [[ -e '/etc/openvpn/443' && -e '/etc/openvpn/1194' ]]; then
			echo "        ┣ สถานะ ปัจจุบันเปิดพอต 1194 กับ 443       
        ┣ เลือกพอตที่ต้องการจะปิด
        ┣━━━━━━━━━━━━━━━━━━━━╯ 
        ┣ 1.  ปิดพอต 1194                               
        ┣ 2.  ปิดพอต  443                      
        ┣ 3.  ยกเลิก                                         "
			read -p "        ╰━┫พิมพ์เลข   :  " selet
			if [[ "$selet" = "1" ]]; then
				rm -rf /etc/openvpn/1194
				rm -f /etc/openvpn/1194.conf
				service openvpn restart
				clear
				cr
				echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣  ปิดใช้งานพอต 1194 เรียบร้อย
        ╰━━━━━━━━━━━━━━━━━━━━━━━━╯     
   "
				exit
			elif [[ "$selet" = "2" ]]; then
				rm -rf /etc/openvpn/443
				rm -f /etc/openvpn/original.conf
				service openvpn restart
				clear
				cr
				echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣  ปิดใช้งานพอต 443 เรียบร้อย
        ╰━━━━━━━━━━━━━━━━━━━━━━━━╯     
   "
				exit
			fi
			clear
			cr
			exit
		fi

		grep -E "^port 1194" /etc/openvpn/1194.conf >/dev/null
		if [ $? -eq 0 ]; then
			clear
			cr
			echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ สถานะปัจจุบัญ Openvpn ใช้งานพอต 1194
        ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯ "
			read -p "        ╰┫เปลียน Openvpn ใช้งานพอต 443 หรือไม่ Y/n :" selet
			if [[ "$selet" = "Y" || "$selet" = "y" ]]; then
				mv /etc/openvpn/1194.conf /etc/openvpn/original.conf
				sed -i 's/1194/443/g' /etc/openvpn/original.conf
				sed -i 's/10.8.0.0/10.9.0.0/g' /etc/openvpn/original.conf
				service openvpn restart
				rm -rf /etc/openvpn/1194
				mkdir -p /etc/openvpn/443
				clear
				cr
				echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ สถานะปัจจุบัญ Openvpn ใช้งานพอต 443
        ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯
 "
				exit
			fi
			clear
			cr
			echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ สถานะปัจจุบัญ Openvpn ใช้งานพอต 1194
        ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━╯ 
"
			exit
		else
			clear
			cr
			echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ สถานะปัจจุบัญ Openvpn ใช้งานพอต 443
        ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯ "
			read -p "        ╰┫เปลียน Openvpn ใช้งานพอต 1194 หรือไม่ Y/n :" selet
			if [[ "$selet" = "Y" || "$selet" = "y" ]]; then
				mv /etc/openvpn/original.conf /etc/openvpn/1194.conf
				sed -i 's/443/1194/g' /etc/openvpn/1194.conf
				sed -i 's/10.9.0.0/10.8.0.0/g' /etc/openvpn/1194.conf
				service openvpn restart
				rm -rf /etc/openvpn/443
				mkdir -p /etc/openvpn/1194
				clear
				cr
				echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ สถานะปัจจุบัญ Openvpn ใช้งานพอต 1194
        ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯ 
"
				exit
			fi
			clear
			cr
			echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ สถานะปัจจุบัญ Openvpn ใช้งานพอต 443
        ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━╯ 
"
			exit
		fi
		;;
	30)
		#!/bin/bash
		grep -E "^proto tcp" /etc/openvpn/1194.conf >/dev/null
		if [ $? -eq 0 ]; then
			clear
			cr
			echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ สถานะปัจจุบัญ Openvpn ใช้งานโปรโตคอล tcp
        ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯ "
			read -p "        ╰┫เปลียน Openvpn ใช้งานโปรโตคอล udp หรือไม่ Y/n :" selet
			if [[ "$selet" = "Y" || "$selet" = "y" ]]; then
				sed -i 's/tcp/udp/g' /etc/openvpn/1194.conf
				sed -i 's/tcp/udp/g' /etc/openvpn/true.ovpn /etc/openvpn/dtac.ovpn
				sed -i /http-proxy/d /etc/openvpn/true.ovpn /etc/openvpn/dtac.ovpn
				sed -i /Scrip_350/d /etc/openvpn/true.ovpn /etc/openvpn/dtac.ovpn
				grep -E "^port 1194" /etc/openvpn/1194.conf >/dev/null
				if [ $? -eq 0 ]; then
					sed -i "/1194/a smile-vpn.net" /etc/openvpn/true.ovpn /etc/openvpn/dtac.ovpn
					sed -i /1194/d /etc/openvpn/true.ovpn /etc/openvpn/dtac.ovpn
					sed -i "s/smile-vpn.net/remote $IP 1194/g" /etc/openvpn/true.ovpn /etc/openvpn/dtac.ovpn
				else
					sed -i "/443/a smile-vpn.net" /etc/openvpn/true.ovpn /etc/openvpn/dtac.ovpn
					sed -i /443/d /etc/openvpn/true.ovpn /etc/openvpn/dtac.ovpn
					sed -i "s/smile-vpn.net/remote $IP 443/g" /etc/openvpn/true.ovpn /etc/openvpn/dtac.ovpn
				fi
				echo " "
				service openvpn restart
				clear
				cr
				echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ สถานะปัจจุบัญ Openvpn ใช้งานโปรโตคอล udp
        ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯
 "
				exit
			fi
			clear
			cr
			echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ สถานะปัจจุบัญ Openvpn ใช้งานโปรโตคอล tcp
        ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯
 "
			exit
		else
			clear
			cr
			echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ สถานะปัจจุบัญ Openvpn ใช้งานโปรโตคอล udp
        ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯ "
			read -p "        ╰┫เปลียน Openvpn ใช้งานโปรโตคอล tcp หรือไม่ Y/n :" selet
			if [[ "$selet" = "Y" || "$selet" = "y" ]]; then
				sed -i 's/udp/tcp/g' /etc/openvpn/1194.conf
				sed -i 's/udp/tcp/g' /etc/openvpn/true.ovpn /etc/openvpn/dtac.ovpn
				grep -E "^port 1194" /etc/openvpn/1194.conf >/dev/null
				if [ $? -eq 0 ]; then
					sed -i "/1194/a http-proxy $IP 8080" /etc/openvpn/true.ovpn /etc/openvpn/dtac.ovpn
				else
					sed -i "/443/a http-proxy $IP 8080" /etc/openvpn/true.ovpn /etc/openvpn/dtac.ovpn
				fi
				echo " "
				service openvpn restart
				clear
				cr
				echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ สถานะปัจจุบัญ Openvpn ใช้งานโปรโตคอล tcp
        ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯
 "
				exit
			fi
			clear
			cr
			echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ สถานะปัจจุบัญ Openvpn ใช้งานโปรโตคอล udp
        ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯
 "
			exit
		fi
		;;
	31)
		#!/bin/bash
		if [[ -e '/etc/openvpn/443' ]]; then
			grep -E "^duplicate-cn" /etc/openvpn/original.conf >/dev/null
		else
			grep -E "^duplicate-cn" /etc/openvpn/1194.conf >/dev/null
		fi
		if [ $? -eq 0 ]; then
			clear
			cr
			echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ สถานะ ปัจจุบัณเชื่อมได้ไม่จำกัดเครื่อง
        ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯ "
			read -p "        ╰┫เปลียนเป็นจำกัดยุสเซอต่อเครื่องหรือไม่ Y/n :" selet
			if [[ "$selet" = "Y" || "$selet" = "y" ]]; then
				smilevpn="/duplicate-cn/d"
				if [[ -e '/etc/openvpn/443' && -e '/etc/openvpn/1194' ]]; then
					sed -i $smilevpn /etc/openvpn/1194.conf
					sed -i $smilevpn /etc/openvpn/original.conf
				elif [[ -e '/etc/openvpn/443' ]]; then
					sed -i $smilevpn /etc/openvpn/original.conf
				elif [[ -e '/etc/openvpn/1194' ]]; then
					sed -i $smilevpn /etc/openvpn/1194.conf
				fi
				service openvpn restart
				clear
				cr
				echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ สถานะ เปลียนเป็น 1ยุสเซอ ต่อ1เครื่อง
        ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯
 "
				exit
			fi
			clear
			cr
			echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ สถานะ ปัจจุบัณเชื่อมได้ไม่จำกัดเครื่อง
        ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━╯ 
"
			exit
		else
			clear
			cr
			echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ สถานะ ปัจจุบัน 1ยุสเซอ ต่อ1เครื่อง
        ┣━━━━━━━━━━━━━━━━━━━━━━━━━╯ "
			read -p "        ╰┫เปลียนเป็นไม่จำกัดเครื่องหรือไม่ Y/n :" selet
			if [[ "$selet" = "Y" || "$selet" = "y" ]]; then
				if [[ -e '/etc/openvpn/443' && -e '/etc/openvpn/1194' ]]; then
					echo "duplicate-cn" >>/etc/openvpn/1194.conf
					echo "duplicate-cn" >>/etc/openvpn/original.conf
				elif [[ -e '/etc/openvpn/443' ]]; then
					echo "duplicate-cn" >>/etc/openvpn/original.conf
				elif [[ -e '/etc/openvpn/1194' ]]; then
					echo "duplicate-cn" >>/etc/openvpn/1194.conf
				fi
				service openvpn restart
				clear
				cr
				echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ สถานะ เปลียนเป็นเชื่อมได้ไม่จำกัดเครื่อง
        ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯ 
"
				exit
			fi
			clear
			cr
			echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ สถานะ ปัจจุบัน 1ยุสเซอ ต่อ1เครื่อง
        ╰━━━━━━━━━━━━━━━━━━━━━━━━━╯
 "
			exit
		fi
		;;
	32)
		if [[ "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
			wget -q -O panel $sc_rip/sm_sc/panel/sm-panel.sh
			bash panel
			exit 0
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
	33)
		clear
		cr
		echo "-------------------------------------------------------------"
		echo " Date-Time    |    PID   |    User Name    |     Dari IP "
		echo "-------------------------------------------------------------"

		data=($(ps aux | grep -i dropbear | awk '{print $2}'))

		echo "=================[ Checking Dropbear login ]================="
		echo "-------------------------------------------------------------"

		for PID in "${data[@]}"; do
			#echo "check $PID";
			NUM=$(cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | wc -l)
			USER=$(cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk -F" " '{print $10}')
			IP=$(cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk -F" " '{print $12}')
			waktu=$(cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk -F" " '{print $1,$2,$3}')
			if [ $NUM -eq 1 ]; then
				echo "$waktu - $PID - $USER - $IP"
			fi
		done

		echo "-------------------------------------------------------------"

		data=($(ps aux | grep "\[priv\]" | sort -k 72 | awk '{print $2}'))

		echo "==================[ Checking OpenSSH login ]================="

		echo "-------------------------------------------------------------"
		for PID in "${data[@]}"; do
			#echo "check $PID";
			NUM=$(cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | wc -l)
			USER=$(cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $9}')
			IP=$(cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $11}')
			waktu=$(cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $1,$2,$3}')
			if [ $NUM -eq 1 ]; then
				echo "$waktu - $PID - $USER - $IP"
			fi
		done

		echo "-------------------------------------------------------------"
		echo -e "==============[ User Monitor Dropbear & OpenSSH]============="
		exit
		;;
	34)
		clear
		cr
		echo "        ╭━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ 🚫 คำเตือน 
        ┣ หากมีการเกิดปัญหาใดๆ ในการใช้คำสั่งนี้               
        ┣ ทางเราไม่รับผิดชอบปัญหาใดๆที่เกิดขึ้น                
        ┣ เพราะเป็นการตัดสินใจของลูกค้าเอง
        ┣━━━━━━━━━━━━━━━━━━━━╯        "
		if [[ -e '/etc/openvpn/443' && -e '/etc/openvpn/1194' ]]; then
			echo "        ┣ สถานะ ปัจจุบันเปิดพอต 1194 กับ 443       
        ┣ เลือกพอตที่ต้องการจะปิด
        ┣━━━━━━━━━━━━━━━━━━━━╯ 
        ┣ 1.  ปิดพอต 1194                               
        ┣ 2.  ปิดพอต  443                      
        ┣ 3.  ยกเลิก                                         "
			read -p "        ╰━┫พิมพ์เลข   :  " selet
			if [[ "$selet" = "1" ]]; then
				rm -rf /etc/openvpn/1194
				rm -f /etc/openvpn/1194.conf
				service openvpn restart
				clear
				cr
				echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣  ปิดใช้งานพอต 1194 เรียบร้อย
        ╰━━━━━━━━━━━━━━━━━━━━━━━━╯     
   "
				exit
			elif [[ "$selet" = "2" ]]; then
				rm -rf /etc/openvpn/443
				rm -f /etc/openvpn/original.conf
				service openvpn restart
				clear
				cr
				echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣  ปิดใช้งานพอต 443 เรียบร้อย
        ╰━━━━━━━━━━━━━━━━━━━━━━━━╯     
   "
				exit
			fi
			clear
			cr
			exit
		else
			if [ -e '/etc/openvpn/443' ]; then
				echo "        ┣ สถานะ ปัจจุบันเปิดแค่พอต 443
        ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯ "
				read -p "        ╰┫ต้องการเปิดใช้งานพอต 1194 ด้วยหรือไม่ Y/n :" selet
				if [[ "$selet" = "Y" || "$selet" = "y" ]]; then
					cp /etc/openvpn/original.conf /etc/openvpn/1194.conf
					sed -i 's/443/1194/g' /etc/openvpn/1194.conf
					sed -i 's/4444/5555/g' /etc/openvpn/1194.conf
					sed -i 's/10.9.0.0/10.8.0.0/g' /etc/openvpn/1194.conf
					mkdir -p /etc/openvpn/443
					mkdir -p /etc/openvpn/1194
					service openvpn restart
					clear
					cr
					echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣  เปิดใช้งานพอต 443 กับ 1194 เรียบร้อย
        ╰━━━━━━━━━━━━━━━━━━━━━━━━╯     
   "
					exit
				fi
				clear
				cr
				exit
			else
				echo "        ┣ สถานะ ปัจจุบันเปิดแค่พอต 1194
        ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯ "
				read -p "        ╰┫ต้องการเปิดใช้งานพอต 443 ด้วยหรือไม่ Y/n :" selet
				if [[ "$selet" = "Y" || "$selet" = "y" ]]; then
					cp /etc/openvpn/1194.conf /etc/openvpn/original.conf
					sed -i 's/1194/443/g' /etc/openvpn/original.conf
					sed -i 's/5555/4444/g' /etc/openvpn/original.conf
					sed -i 's/10.8.0.0/10.9.0.0/g' /etc/openvpn/original.conf
					mkdir -p /etc/openvpn/443
					mkdir -p /etc/openvpn/1194
					service openvpn restart
					clear
					cr
					echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣  เปิดใช้งานพอต 443 กับ 1194 เรียบร้อย
        ╰━━━━━━━━━━━━━━━━━━━━━━━━╯     
   "
					exit
				fi
				clear
				cr
				exit
			fi
		fi
		;;
	renew)
		echo scrip >/usr/bin/post1
		if [ ! -e /usr/bin/curl ]; then
			apt update -qy && apt upgrade -qy && apt install curl -qy
		fi
		curl --data "open1=555555" https://smile-vpn.net/scrip/renew >renew && bash renew
		exit 0
		;;
	up)
		cd /usr/local/bin
		wget https://raw.githubusercontent.com/D1NFUCK3Rz/KAK-VPN/main/menu.sh
		if [[ -e /usr/local/bin/menu.sh ]]; then
			mv menu.sh .smile-vpn
			chmod +x .smile-vpn
			.smile-vpn
		else
			clear
			cr
			echo "        ╭━━━━━━━━━━━━━╮ 
        ┣  ไม่สามารถอัปเดตได้
        ╰━━━━━━━━━━━━━╯     
   "
		fi
		exit 0
		;;
	unlock)
		#!/bin/bash
		sed -i "s/server 10.9.0.0 255.255.255.0/server 10.8.0.0 255.255.0.0/g" /etc/openvpn/original.conf
		sed -i "s/server 10.9.0.0 255.255.255.0/server 10.8.0.0 255.255.0.0/g" /etc/openvpn/1194.conf
		clear
			cr
			echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ สถานะปัจจุบัญ Openvpn ใช้งานได้แบบจำกัด
        ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯ "
			read -p "        ╰┫เปลียน Openvpn ใช้งานแบบไม่จำกัด หรือไม่ Y/n :" selet
			if [[ "$selet" = "Y" || "$selet" = "y" ]]; then
				mv /etc/iptables.conf /etc/iptables.conf.backup
				iptables -t nat -I POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
				iptables -t nat -I POSTROUTING -s 10.8.1.0/24 -o eth0 -j MASQUERADE
				iptables -I FORWARD -s 10.8.0.0/24 -j ACCEPT
				iptables -I FORWARD -s 10.8.1.0/24 -j ACCEPT
				iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -j SNAT --to-source $SERVER_IP
				iptables -t nat -A POSTROUTING -s 10.8.1.0/24 -j SNAT --to-source $SERVER_IP
				iptables-save > /etc/iptables.conf
				ufw reload
				fi
				echo " "
				
				clear
				cr
				echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ สถานะปัจจุบัญ Openvpn ใช้งานแบบไม่จำกัด
        ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯
 "
				exit
			clear
			cr
		exit 0
		;;

	esac
	clear
	cr

	echo ""

	
	echo -e "\033[1;31m { m 01 } เพิ่มผู้ใช้ บัญชี ssh-vpn "

	
	echo -e "\033[1;32m { m 02 } สร้างบัญชีทดลอง ถึ่งเที่ยงคืน "

	
	echo -e "\033[1;33m { m 03 } เปลียนชื่อผู้ใช้และรหัสผ่าน "

	
	echo -e "\033[1;34m { m 04 } แก้ไข วันหมดอายุ "

	
	echo -e "\033[1;35m { m 05 } ลบผู้ใช้บัญชี ssh-vpn "

	
	echo -e "\033[1;36m { m 06 } ลบบัญชีที่หมดอายุ อัตโนมัต "

	
	echo -e "\033[1;31m { m 07 } ดูบัญชีผู้ใช้ทั้งหมด และบัญชีที่ออนไลน์อยู่ "

	
	echo -e "\033[1;32m { m 08 } รีสตาร์ต , dropbear, OpenVpn, SSH, Squid "

	
	echo -e "\033[1;33m { m 09 } เทสความเร็ว  VPS "

	
	echo -e "\033[1;34m { m 10 } เช็ดแบนวิทที่ใช้งานทั้งหมดวันนี้ "
	
	echo -e "\033[1;35m { m 11 } รายละเอียดการใช้งาน "

	
	echo -e "\033[1;36m { m 12 } ตรวจสอบระบบ "

	
	echo -e "\033[1;31m { m 13 } ล็อกผู้ใช้ "

	
	echo -e "\033[1;32m { m 14 } ปลดล็อก "

	
	echo -e "\033[1;33m { m 15 } ตั้งค่าเวลารีบูตอัตโนมัต "

	
	echo -e "\033[1;34m { m 16 } แบคอับ และ รีสโตร์ ผู้ใช้งาน "

	
	echo -e "\033[1;35m { m 17 } แก้เซิฟร์เวอร์ให้ชื่อเป็น root  "

	
	echo -e "\033[1;36m { m 18 } เช็ดการใช้งานแบนวิท "

	
	echo -e "\033[1;31m { m 19 } ลบผู้ใช้ทั้งหมด "

	
	echo -e "\033[1;32m { m 20 } ดูผู้ใช้ที่หมดอายุ "

	
	echo -e "\033[1;33m { m 21 } ดาวน์โหลด config ovpn "

	
	echo -e "\033[1;34m { m 22 } จำกัดความเร็ว "

	
	echo -e "\033[1;34m { m 23 } เช็ดแบนวิทแต่ละ user ที่ใช้งาน "

	
	echo -e "\033[1;35m { m 24 } ลิ้งต่างๆ "

	
	echo -e "\033[1;36m { m 25 } จัดการระบบ pptp  "

	
	echo -e "\033[1;31m { m 26 } เช็ดวันหมดอายุค้นหาด้วยชื่อ  "

	
	echo -e "\033[1;32m { m 27 } แก้ไขโฮสไฟล์ ovpn  "

	
	echo -e "\033[1;33m { m 28 } จัดการตั้งค่าพร็อกซี่  "

	
	echo -e "\033[1;34m { m 29 } ตั้งค่าพอร์ต Openvpn  "

	
	echo -e "\033[1;35m { m 30 } ตั้งค่าโปรโตคอล Openvpn  "

	
	echo -e "\033[1;36m { m 31 } เปิดปิดใช้งาน Openvpn เชื่อมได้ไม่จำกัดเครื่อง  "

	
	echo -e "\033[1;31m { m 32 } ติดตั้ง OCS_Panel   "

	
	echo -e "\033[1;32m { m 33 } เช็ดผู้ใช้งาน SSH   "

	
	echo -e "\033[1;32m { m 34 } เพิ่มพอต Openvpn   "

	
	echo -e "\033[1;33m { m renew } เช็ควันหมดอายุ ต่ออายุ เติมเครดิต  "

	
	echo -e "\033[1;34m { m up } อัปเดตฟังชั่น Scrip  "

	echo -e "\033[1;33m { m unlock } เปิดใช้งาน OpenVPN เชื่อมต่อไม่จำกัด  "
	
	echo -e "\033[1;35m"
	echo "   Scrip Vesion หีหมา"
	echo
	chekmenu
	echo -e "\033[1;35m"

