#!/bin/bash
./01_disable_selinux.sh
./02_install_packages.sh
./03_start_firewall.sh
./04_create_docker_inscure_config.sh
./06_create_certs.sh
./07_install_nginx.sh
./08_cretate_config.sh

