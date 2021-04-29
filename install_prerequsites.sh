#!/bin/bash
echo "updating repositories"
sudo apt update

echo "adding ansible/ansible repository for automatic  updates"
sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible

echo "Installing ansible"
sudo apt install ansible

echo "installing ansible-galaxy collection packages for EXOS" 
sudo ansible-galaxy collection install community.network
sudo ansible-galaxy collection install extreme.exos
echo "setting up ssh-agent for ansible"
ssh-agent bash
ssh-add ~/.ssh/known_hosts
export ANSIBLE_HOST_KEY_CHECKING=False

exec bash
