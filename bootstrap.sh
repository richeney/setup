#!/bin/bash

set -x

ssh-keygen -m PEM -t rsa -b 4096

sudo apt update && sudo apt full-upgrade -y
sudo apt install python3-pip ansible

umask 022

cat << ANSIBLE_CFG > ~/.ansible.cfg
[defaults]
inventory = ~/ansible/hosts
roles_path = ~/.ansible/roles
deprecation_warnings=False
nocows = 1
ANSIBLE_CFG

mkdir -pm 755 ~/ansible && cd ~/ansible

cat << ANSIBLE_HOSTS > ~/ansible/hosts
[localhost]
127.0.0.1
ANSIBLE_HOSTS

## Switch requirements.yml abnd playbook.yml to curl downloads

cat << ANSIBLE_REQS > ~/ansible/requirements.yml
---
- src: https://github.com/richeney/ansible-role-azure-cli
  name: azure_cli
...
ANSIBLE_REQS

ansible-galaxy install -r requirements.yml

curl -H 'Cache-Control: no-cache' -sSL https://raw.githubusercontent.com/richeney/ubuntu/master/playbook.yml?token=AF5565XVBPRK5SVT56GFWPK636M2M --output ~/ansible/playbook.yml

ansible-playbook ~/ansible/playbook.yml --ask-become-pass
