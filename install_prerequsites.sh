#!/bin/bash
echo "installing prerequisites"
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository ppa:gns3/ppa
sudo apt update
sudo apt install -y python3 python3-pip




echo  "installing specific connection requirements for fortinet"
pip3 install -r requirements.txt

echo "installing ansible-galaxy collection packages for EXOS and Fortinet" 
ansible-galaxy collection install community.network
ansible-galaxy collection install extreme.exos
ansible-galaxy collection install -f fortinet.fortios:2.0.0

echo "setting up ssh-agent for ansible"
ssh-agent bash
ssh-add ~/.ssh/known_hosts
export ANSIBLE_HOST_KEY_CHECKING=False

echo "installing GNS3"                               
sudo apt install gns3  

exec bash
