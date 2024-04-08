#!/bin/bash
dnf install -y nginx
\cp -p ./nginx.conf /etc/nginx/
systemctl enable nginx --now
