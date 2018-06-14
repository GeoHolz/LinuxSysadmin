#!/usr/bin/python
# -*- coding: utf-8 -*-
"""Notifies myself of IP change."""
import smtplib
import requests
import os
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

ADDRESS_FILE = '/tmp/old_ip_address.txt'


fromaddr = "CHANGE_ME@gmail.com"
toaddr = "OR_NOT@gmail.com"


try:
    currIp = requests.get('https://api.ipify.org').text # Get the current IP address
except (HTTPError, URLError, socket.timeout) as err:
    exit()
else:
    if not os.path.isfile(ADDRESS_FILE): #If the ADDRESS_FILE doesn't exists, create it
        f = open(ADDRESS_FILE, 'w')
        f.write('127.0.0.1')
        f.close()
    f = open(ADDRESS_FILE, 'r') #Read the old IP address
    oldIp = f.read()
    f.close()
    if currIp != oldIp: #If IP address changed, send email with gmail account
        msg = MIMEMultipart()
        msg['From'] = fromaddr
        msg['To'] = toaddr
        msg['Subject'] = "LThe IP address has changed"
        msg.attach(MIMEText("The new IP address is : "+currIp, 'plain'))
        server = smtplib.SMTP('smtp.gmail.com', 587)
        server.starttls()
        server.login(fromaddr, "MY_PASSWORD")
        text = msg.as_string()
        server.sendmail(fromaddr, toaddr, text)
        server.quit()
    f = open(ADDRESS_FILE, 'w') #Write the new IP address into the file
    f.write(currIp)
    f.close()    
