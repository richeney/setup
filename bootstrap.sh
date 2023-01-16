#!/bin/bash

set -x

[ ! -s ~/.ssh/id_rsa -o ! -s ~/.ssh/id_rsa.pub ] && ssh-keygen -m PEM -t rsa -b 4096

sudo apt update && sudo apt full-upgrade -y
sudo apt install python3-pip ansible tree -y

umask 022

sudo touch ~/.bash_history && sudo chown $USER:$USER ~/.bash_history && chmod 644 ~/.bash_history

cat << ANSIBLE_CFG > ~/.ansible.cfg
[defaults]
inventory = ~/ansible/hosts
roles_path = ~/ansible/roles
deprecation_warnings=False
nocows = 1
ANSIBLE_CFG

mkdir -pm 755 ~/ansible && cd ~/ansible

cat << ANSIBLE_HOSTS > ~/ansible/hosts
[localhost]
127.0.0.1
ANSIBLE_HOSTS

## Switch requirements.yml and playbook.yml to curl downloads

cat << ANSIBLE_REQS > ~/ansible/requirements.yml
---
- src: https://github.com/richeney/ansible-azure-cli
  name: azure_cli
- src: https://github.com/richeney/ansible-wsl-colours
  name: wsl_colours
- src: https://github.com/richeney/ansible-install-terraform
  name: terraform
- src: https://github.com/richeney/ansible-install-packer
  name: packer
...
ANSIBLE_REQS

ansible-galaxy install -r requirements.yml

curl -H 'Cache-Control: no-cache' -sSOL https://raw.githubusercontent.com/richeney/setup/master/playbook.yml
curl -H 'Cache-Control: no-cache' -sSOL https://raw.githubusercontent.com/richeney/setup/master/bashrc_user_customisations

tree ~/ansible

cat << INSTRUCTIONS

Run:

ansible-playbook ~/ansible/playbook.yml

INSTRUCTIONS
