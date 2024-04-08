#!/bin/bash
# Sorry Ishikawa-san
setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config
