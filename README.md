# gitlab_compose
Using the artifacts from this repository, you can add registry functionality and HTTPS to GitLab and get it up and running!

## Procedure

### Disable SELinux
```
setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config
```

### Install development tools
```
sudo dnf install -y gcc zlib-devel bzip2 bzip2-devel readline readline-devel sqlite sqlite-devel openssl openssl-devel git libffi-devel make cmake bash-completion
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install -y docker-ce --nobest
```

### Clone this repository
```
git clone https://github.com/konono/gitlab_compose.git
cd ./gitlab_compose
```

### firewall configuration
```
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
```

### Start docker daemon
```
sudo systemctl enable docker --now
cat << EOF > /etc/docker/daemon.json
{
  "insecure-registries" : ["`ip -4 -o a show ens6 |awk '{print $4}'|sed -e 's/\/.*//g'`:10443"]
}
EOF
sudo systemctl restart docker
```

### **If you use ipv6** do this procedure create docker network for ipv6
```
docker network create  --driver=bridge --subnet=172.20.0.0/24 --gateway=172.20.0.1 --ipv6 --subnet=2001:db8:13b:1000:ffff::/80 --gateway=2001:db8:13b:1000:ffff::1 frontend -o com.docker.network.bridge.name="frontend" -o com.docker.network.bridge.enable_ip_masquerade=true
```

### Install docker-compose
```
curl -L https://github.com/docker/compose/releases/download/v2.26.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Add to PATH
echo 'PATH="/usr/local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Install python and pip
```
sudo dnf install -y python3.11 python3.11-pip
pip3.11 install ansible

```

### Create certs
```
pip3 install ansible passlib
cd gitlab_compose/scripts/
ansible-playbook create_certs_v1.yml
```

### Install and configure nginx
```
dnf install -y nginx
\cp -p ./nginx.conf /etc/nginx/
systemctl enable nginx --now
```

### Run GitLab
```
docker-compose up -d
```
