#!/bin/bash
docker network create  --driver=bridge --subnet=172.20.0.0/24 --gateway=172.20.0.1 --ipv6 --subnet=2001:db8:13b:1000:ffff::/80 --gateway=2001:db8:13b:1000:ffff::1 br_gitlab_nw -o com.docker.network.bridge.name="br_gitlab_nw" -o com.docker.network.bridge.enable_ip_masquerade=true
