echo Resetting console cable - please wait...
sleep 1
echo Finding USB port for FTDI device...
ftdiPort=$(lsusb -t | grep ftdi | sed s/^[[:space:]]*//g|cut -d ' ' -f 3|sed s/://g)
echo "Port is ${ftdiPort}"
echo "Tree is 1-1.${ftdiPort}"
sleep 1
echo -n Sending unbind request to USB bus using ID 
echo "1-1.${ftdiPort}" | sudo tee /sys/bus/usb/drivers/usb/unbind
sleep 1
echo -n Sending bind request to USB bus using ID 
echo "1-1.${ftdiPort}" | sudo tee /sys/bus/usb/drivers/usb/bind
sleep 1
echo Done.
