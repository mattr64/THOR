## THOR - The Hands Of Remote 
---------------------------------------------------------

This is/was a pet project to create a remote serial line over cellular using cheap components. Using a RPi 3 or 4 with an LTE dongle, a USB-Serial adapter and a 16x2 matrix screen, these scripts aim to configure the system in a way which looks after itself for the most part. 

The system was connected and shipped in a robust waterproof container to a remote site and had everything attached to USB extension cables and a magnetic LTE antenna. An inexperienced user could then plug this into a) switch console, b) power, c) ensure the antenna is high up. On boot, signal strength and status will be displayed on the 16x2 screen.

As a backup, one can create a local WiFi network hotspot for this device to connect to. There are scripts to force routing priority between WiFi and Cellular no matter the media speed.
Serial lines are automatically refreshed, and if they get stuck, USB ports are cycled. 

It's essentially a box of tricks that helped out in several remote deployments, avoiding having to send expensive network engineers out every time.
