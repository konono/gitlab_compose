#!/bin/bash
systemctl enable firewalld --now

firewall-cmd  --zone=public --add-port=10022/tcp
firewall-cmd  --zone=public --add-port=80/tcp
firewall-cmd  --zone=public --add-port=443/tcp
firewall-cmd  --zone=public --add-port=8080/tcp
firewall-cmd  --zone=public --add-port=10443/tcp
firewall-cmd  --zone=public --add-port=10022/tcp --permanent
firewall-cmd  --zone=public --add-port=80/tcp --permanent
firewall-cmd  --zone=public --add-port=443/tcp --permanent
firewall-cmd  --zone=public --add-port=8080/tcp --permanent
firewall-cmd  --zone=public --add-port=10443/tcp --permanent

