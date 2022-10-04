#!/bin/bash
if [[ "on" = "$1" ]]; then
mv /usr/bin/.350_fulle-off /usr/bin/.350_fulle

clear
cr
echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ เปิดใช้งานฟังชั่นสคริปเรียบร้อย
        ┣ พิมพ์ [ scrip_sm off ] เพื่อปิดใช้งาน
        ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━╯
 "
exit
fi

if [[ "off" = "$1" ]]; then
mv /usr/bin/.350_fulle /usr/bin/.350_fulle-off

clear
cr
echo "        ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━╮ 
        ┣ ปิดใช้งานฟังชั่นสคริปเรียบร้อย
        ┣ พิมพ์ [ scrip_sm on ] เพื่อเปิดใช้งาน
        ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━╯
 "
exit
fi
