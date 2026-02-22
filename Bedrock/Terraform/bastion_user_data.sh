#!/bin/bash
sudo apt update -y
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible


mkdir -p /home/ubuntu/.ssh
cat <<EOF > /home/ubuntu/.ssh/id_rsa
${private_key}
EOF
chmod 600 /home/ubuntu/.ssh/id_rsa
chown ubuntu:ubuntu /home/ubuntu/.ssh/id_rsa