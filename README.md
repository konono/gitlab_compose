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
```

### firewall configuration
```
./gitlab_compose/start_firewall.sh
```

### Start docker daemon
```
sudo systemctl enable docker --now
cat << EOF > /etc/docker/daemon.json
{
  "insecure-registries" : ["`ip -4 -o a show ens6 |awk '{print $4}'|sed -e 's/\/.*//g'`"]
}
EOF
sudo systemctl restart docker
```

### Create docker network for ipv6
```
./gitlab_compose/create_gitlab_nw.sh
```

### Install docker-compose
```
curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

### Install pyenv
```
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
echo 'export PATH="$PATH:$HOME/bin"' >> ~/.bash_profile
echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(pyenv init -)"' >> ~/.bash_profile
echo 'eval "$(pyenv init --path)"' >> ~/.bash_profile
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile
pyenv install 3.9.7
pyenv global 3.9.7
```

### Create certs
```
pip3 install ansible passlib
cd gitlab_compose
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
