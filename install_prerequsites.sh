#!/bin/bash

echo "installing python3 prerequisites"
sudo apt install -y python3 python3-pip
echo "installing python3 prerequisites"
python3 install pip


echo "Installing ansible via pip3"
pip3 install ansible

echo "installing ansible-galaxy collection packages for EXOS and Fortinet" 
ansible-galaxy collection install community.network
ansible-galaxy collection install extreme.exos
ansible-galaxy collection install -f fortinet.fortios:1.0.11
echo "setting up ssh-agent for ansible"
ssh-agent bash
ssh-add ~/.ssh/known_hosts
export ANSIBLE_HOST_KEY_CHECKING=False

exec bash
