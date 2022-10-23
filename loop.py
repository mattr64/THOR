#!/usr/bin/python3
import requests
import json
import time
import os
import time
import liquidcrystal_i2c
import socket
import os.path
import sys
import struct
import fcntl

lcd = liquidcrystal_i2c.LiquidCrystal_I2C(0x27, 1, numlines=4)

count0 = 45
while count0:
    time.sleep(1)
    pstr= 'Waiting for modem...'
    lcd.printline(0,pstr)
    pstr= 'Please wait.'
    lcd.printline(1,pstr)
    pstr= ''
    lcd.printline(2,pstr)
    count0str = str(count0)
    lcd.printline(3,count0str)
    count0 -= 1

pstr= 'Modem ready.'
lcd.printline(0,pstr)
pstr= 'Please wait.'
lcd.printline(1,pstr)
pstr= '#'
lcd.printline(2,pstr)
pstr= 'Setting up headers'
lcd.printline(3,pstr)
cookies = {
    'stok': '9F290688A6C1AD12F1B13077',
}

headers = {
    'Accept': 'application/json, text/javascript, */*; q=0.01',
    'Accept-Language': 'en-GB,en-US;q=0.9,en;q=0.8',
    'Connection': 'keep-alive',
    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
    'Origin': 'http://192.168.0.1',
    'Referer': 'http://192.168.0.1/index.html',
    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36',
    'X-Requested-With': 'XMLHttpRequest',
}

data = {
    'isTest': 'false',
    'goformId': 'LOGIN',
    'password': 'eWVsbG93MTE=',
}
count1 = 5
pstr= '##'
lcd.printline(2,pstr)
pstr= 'Auth to LTE USB...'
lcd.printline(3,pstr)
while count1 < 10:
  count2 = 1
  # print('Starting session...')
  s = requests.Session()
  # print('Setting up request R1')
  r1 = s.post('http://192.168.0.1/goform/goform_set_cmd_process', cookies=cookies, headers=headers, data=data, verify=False)
  # print ('Executing request R1')
  # print(r1.status_code)
  pstr= '###'
  lcd.printline(2,pstr)
  pstr= 'Authenticated.'
  lcd.printline(3,pstr)
  pstr= '#####'
  lcd.printline(2,pstr)
  pstr= 'Getting stats...'
  lcd.printline(3,pstr)

  pstr= '#                   '
  lcd.printline(0,pstr)
  pstr= '#                   '
  lcd.printline(1,pstr)
  pstr= '#                   '
  lcd.printline(2,pstr)
  pstr= '#                   '
  lcd.printline(3,pstr)


  # print('Login success - session established. Running RSSI loop')
  headers2 = {
        'Accept': 'application/json, text/javascript, */*; q=0.01',
        'Accept-Language': 'en-GB,en-US;q=0.9,en;q=0.8',
        'Connection': 'keep-alive',
        'Referer': 'http://192.168.0.1/index.html',
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36',
        'X-Requested-With': 'XMLHttpRequest',
  }
  params2 = {
        'isTest': 'false',
        'cmd': 'apn_interface_version,wifi_coverage,m_ssid_enable,imei,network_type,rssi,rscp,lte_rsrp,imsi,sim_imsi,cr_version,wa_version,hardware_version,web_version,wa_inner_version,MAX_Access_num,SSID1,AuthMode,WPAPSK1_encode,m_SSID,m_AuthMode,m_HideSSID,m_WPAPSK1_encode,m_MAX_Access_num,lan_ipaddr,mac_address,msisdn,LocalDomain,wan_ipaddr,static_wan_ipaddr,ipv6_wan_ipaddr,ipv6_pdp_type,ipv6_pdp_type_ui,pdp_type,pdp_type_ui,opms_wan_mode,ppp_status,cable_wan_ipaddr',
        'multi_data': '1',
        '_': '1654439283962',
  }
  while count2 < 10:
    r2 = s.get('http://192.168.0.1/goform/goform_get_cmd_process', params=params2, cookies=cookies, headers=headers2, verify=False)
    time.sleep(1)
    pstr= 'THOR Alpha Test Kit'
    lcd.printline(0,pstr)
    pstr= '## Online, Ready'
    lcd.printline(1,pstr)
    # print("Signal strength:",r2.json()["rssi"])
    # print("Network type:   ",r2.json()["network_type"])
    rssi_str = json.dumps(r2.json()["rssi"])
    rssi_str = rssi_str.replace('"', '')
    rssi_str = "Cell RSSI: " + rssi_str
    # print(rssi_str)
    lcd.printline(2,rssi_str)
    net_str = json.dumps(r2.json()["network_type"])
    net_str = net_str.replace('"', '')
    net_str = "Net Type: " + net_str
    # print(net_str)
    lcd.printline(3,net_str)
    # print(count2)
    count2 += 1
    time.sleep(5)
