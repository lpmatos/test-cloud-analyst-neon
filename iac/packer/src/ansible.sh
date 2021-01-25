#!/bin/bash
set -ex

echo "Setup Ansible"
sudo yum -y install python3
sudo yum -y install python3-pip
sudo pip3 install ansible

echo "Setup Apache"
sudo yum -y install httpd
