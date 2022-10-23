#!/usr/bin/env python
"""first please add python library via this command: python -m easy_install --user https://github.com/pl31/python-liquidcrystal_i2c/archive/master.zip """
import socket
import os.path
import sys
import struct
import fcntl
import os
import time
import liquidcrystal_i2c
efg = "1"
wfg = "0"
lcd = liquidcrystal_i2c.LiquidCrystal_I2C(0x27, 1, numlines=4)
PATH1="/sys/class/net/eth0/carrier"
PATH2 = "/sys/class/net/wlan0/carrier"
def getserial():
    snm = "0000000000000000"
    try:
        f = open('/proc/cpuinfo','r')
        for line in f:
            if line[0:6]=='Serial':
                snm = line[10:26]
        f.close()
    except:
        snm = "ERROR"
    return snm

def getip(ifname):
    tt=0
    while tt<100:
        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
            return socket.inet_ntoa(fcntl.ioctl(s.fileno(),0x8915,struct.pack('256s',ifname[:15]))[20:24])
        except:
            tt+=1
            time.sleep(1)
            if(tt>99):
                return('ERROR')
time.sleep(15)
pstr= 'SN:'+getserial()
lcd.printline(0,pstr)
pstr = 'THOR Remote Access'
lcd.printline(1,pstr)
pstr = '*** System OK! ***'
# pstr = pstr.strip('\n')
lcd.printline(2,pstr)
pstr="WIP:"+str(getip('wlan0'))
lcd.printline(3,pstr)
