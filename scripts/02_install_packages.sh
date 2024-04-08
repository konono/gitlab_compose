#!/bin/bash
# install python pip
sudo dnf install -y python3.11 python3.11-pip

# install developper tool
sudo dnf install -y gcc zlib-devel bzip2 bzip2-devel readline readline-devel sqlite sqlite-devel openssl openssl-devel git libffi-devel make cmake bash-completion

# install docker-ce
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install -y docker-ce --nobest

# install docker-compose
curl -L https://github.com/docker/compose/releases/download/v2.26.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# install ansible
pip3.11 install ansible

# Add to PATH
echo 'PATH="/usr/local/bin:$PATH"' >> ~/.bashrc
