if [[ -e /usr/bin/ipsm ]]; then
IP=$(cat /usr/bin/ipsm);
fi
if [[ "$IP" = "" ]]; then
    IP=$(hostname -I | sed -n '1p' | awk '{print $1}')
fi
echo
echo -e "\e[31m 
            ╭⊹⊱s̴c̴r̴i̴p̴t̴ f̴u̴l̴l̴ f̴u̴n̴c̴t̴i̴o̴n̴ S̴e̴r̴v̴e̴r̴ v̴p̴n̴⊰⊹╮        
    ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮                "
    sleep 0.01
echo -e "\e[32m    ┣┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┫          "
    sleep 0.01
echo -e "\e[33m    ┣┈┈╭━━━━╮╭━━╮╭━━╮╭━━━━━╮╭━━╮┈┈╭━━━━╮┈┈┫          "
    sleep 0.01
echo -e "\e[34m    ┣┈┈┃╱╱━━┫┃╱╱┃┃╱╱┃╰━╮╱╭━╯┃╱╱┃┈┈┃╱╱━━┫┈┈┫          "
    sleep 0.01
echo -e "\e[35m    ┣┈┈┣━━╱╱┃┃╱┃╰╯┃╱┃╭━╯╱╰━╮┃╱╱┗━╮┃╱╱━━┫┈┈┫          "
    sleep 0.01
echo -e "\e[36m    ┣┈┈╰━━━━╯╰━┻━━┻━╯╰━━━━━╯╰━━━━╯╰━━━━╯┈┈┫          "
    sleep 0.01
echo -e "\e[31m    ┣┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┫          "
    sleep 0.01
echo -e "\e[32m    ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫          "
    sleep 0.01
echo -e "\e[33m    ┣━━┫   Scrip Mod By KUY VPN ควยไรมึง         "
    sleep 0.01
echo -e "\e[34m    ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫               "
echo -e "\e[35m    ╰━━━━━━━━━━━━━┫ Server IP $IP    "
