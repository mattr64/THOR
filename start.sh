clear
echo
bold=$(tput bold)
normal=$(tput sgr0)
echo '           )    )  (     '
echo '  *   ) ( /( ( /(  )\ )  '
echo '` )  /( )\()))\())(()/(  '
echo ' ( )(_)|(_)\((_)\  /(_)) '
echo '(_(_()) _((_) ((_)(_))   '
echo '|_   _|| || |/ _ \| _ \  '
echo '  | |  | __ | (_) |   /  '
echo '  |_|  |_||_|\___/|_|_\  '
echo
echo "*************************************************"
echo "${bold}THOR Remote Access Node, ID 2 ${normal}"
echo "*************************************************"
echo "This node is Cellular enabled via ETH0"
echo
echo "*************************************************"
echo
echo
echo About to connect to /dev/ttyUSB0 - ${bold}connect device now!${normal}
echo
echo To disconnect screen session, use CTRL+A and K then Y
echo
echo "${bold}Serial garbled or not connecting? ${normal}"
echo "-------------------------------------------------"
echo If serial port is stuck, cycle using ./cycleSerial.sh
echo if serial port fails to reinitialise, use ./forceSerialEnable.sh
echo If serial continues to fail, reboot with sudo reboot
echo
echo This is a testing system that is not for general use
echo For any questions contact Matt on +447547730494
echo
echo
read -p "Press enter to continue"
echo
echo
screen /dev/*USB*
