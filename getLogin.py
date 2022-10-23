import requests
password = 'yellow11'
response = requests.get('http://192.168.0.1', auth=(password))
print(response.json()) 
