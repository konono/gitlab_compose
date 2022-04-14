#!/bin/bash
firewall-cmd --zone=public --add-masquerade
firewall-cmd --zone=public --add-masquerade --permanent
firewall-cmd --direct --add-rule ipv6 nat POSTROUTING 0 -o [OUTPUT_IF] -j MASQUERADE
firewall-cmd --direct --permanent --add-rule ipv6 nat POSTROUTING 0 -o [OUTPUT_IF] -j MASQUERADE
firewall-cmd --direct --add-rule ipv6 filter FORWARD 0 -i frontend -o [OUTPUT_IF] -j ACCEPT
firewall-cmd --direct --permanent --add-rule ipv6 filter FORWARD 0 -i frontend -o [OUTPUT_IF] -j ACCEPT
firewall-cmd --direct --add-rule ipv6 filter FORWARD 0 -i frontend -o [OUTPUT_IF] -m state --state RELATED,ESTABLISHED -j ACCEPT
firewall-cmd --direct --permanent --add-rule ipv6 filter FORWARD 0 -i frontend -o [OUTPUT_IF] -m state --state RELATED,ESTABLISHED -j ACCEPT
