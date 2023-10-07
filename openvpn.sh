#!/bin/sh
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color



echo "Running as root..."
sleep 2
clear


opkg update

opkg install openvpn-openssl

sleep 2

opkg install luci-app-openvpn


uci set network.OVPNER=interface

uci set network.OVPNER.proto='none'

uci set network.OVPNER.device='tun0'

uci commit



RESULT=`grep -o OVPNER /etc/config/firewall`
            if [ "$RESULT" == "OVPNER" ]; then
            echo -e "${GREEN}Cool !${NC}"

 else

            echo -e "${YELLOW}Replacing${YELLOW}"
			
echo "config zone
        option name 'SIXOS'
        option input 'ACCEPT'
        option output 'ACCEPT'
        option forward 'REJECT'
        option masq '1'
        option mtu_fix '1'
        list network 'OVPNER'

config forwarding
        option src 'lan'
        option dest 'SIXOS'" >> /etc/config/firewall



fi

echo -e "${GREEN} Made With Love By : AmirHossein Choghaei ${NC}"
