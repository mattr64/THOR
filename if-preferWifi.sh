echo Resetting DHCPCD config metric to prefer WiFi...
  cp /etc/dhcpcd-wifi.conf /etc/dhcpcd.conf
echo Restarting DHCP Client Daemon...
  systemctl restart dhcpcd
echo Waiting 4 seconds for DHCP leases to renew on Cellular interface...
sleep 4
echo Done. Route below should reflect preferred default gateways.
route -n
