#!/bin/bash
dnf install -y nginx
\cp -p ../configs/nginx.conf /etc/nginx/
systemctl enable nginx --now
