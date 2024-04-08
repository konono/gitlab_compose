sudo systemctl enable docker --now
cat << EOF > /etc/docker/daemon.json
{
  "insecure-registries" : ["`ip -4 -o a show ens6 |awk '{print $4}'|sed -e 's/\/.*//g'`:10443"]
}
EOF
sudo systemctl restart docker

