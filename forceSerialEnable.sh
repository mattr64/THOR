echo Force enable of all USB devices... ignore all errors below.
echo 
echo
echo "1-1.5" | sudo tee /sys/bus/usb/drivers/usb/bind
echo "1-1.1" | sudo tee /sys/bus/usb/drivers/usb/bind
echo "1-1.2" | sudo tee /sys/bus/usb/drivers/usb/bind
echo "1-1.3" | sudo tee /sys/bus/usb/drivers/usb/bind
echo "1-1.4" | sudo tee /sys/bus/usb/drivers/usb/bind
echo "1-1.6" | sudo tee /sys/bus/usb/drivers/usb/bind
echo "1-1.7" | sudo tee /sys/bus/usb/drivers/usb/bind
echo "1-1.8" | sudo tee /sys/bus/usb/drivers/usb/bind
echo "1-1.9" | sudo tee /sys/bus/usb/drivers/usb/bind

echo
echo
echo Done. If serial still does not connect, reboot device.
echo If device still does not work after reboot, send field engineer.
