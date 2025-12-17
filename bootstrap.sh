#!/usr/bin/env bash
set -e

# Ensure ansible folder exists
mkdir -p ~/ansible

# Detect local repo usage (no branch check)
USE_LOCAL_PLAYBOOK=false

if command -v git >/dev/null 2>&1; then
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    ORIGIN_URL=$(git config --get remote.origin.url)
    # Accept both SSH and HTTPS remote URLs
    if [[ "$ORIGIN_URL" =~ github.com[/:]richeney/setup(\.git)?$ ]]; then
      if [ -f "./playbook.yml" ]; then
        USE_LOCAL_PLAYBOOK=true
        REPO_DIR=$(pwd)
      fi
    fi
  fi
fi

# Continue with other setup as needed...

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

## Download playbook and customisations
## wsl_colours role is still needed

cat << ANSIBLE_REQS > ~/ansible/requirements.yml
---
- src: https://github.com/richeney/ansible-wsl-colours
  name: wsl_colours
...
ANSIBLE_REQS

ansible-galaxy install -r requirements.yml

if $USE_LOCAL_PLAYBOOK; then
  echo "Using local files from git repository."
  for file in playbook.yml bashrc_user_customisations; do
    echo "Copying $file"
    cp $REPO_DIR/"$file" ~/ansible/"$file"
  done
else
  RAW_REPO_URL="https://raw.githubusercontent.com/richeney/setup/main"
  echo "Downloading files from $RAW_REPO_URL"
  for file in playbook.yml bashrc_user_customisations; do
    echo "Downloading $file"
    curl -fsSL "$RAW_REPO_URL/$file" -o ~/ansible/"$file"
    if [ ! -s ~/ansible/"$file" ]; then
      echo "ERROR: Could not obtain $file from main branch!"
      exit 1
    fi
  done
fi

tree ~/ansible

cat << INSTRUCTIONS

Run:

ansible-playbook ~/ansible/playbook.yml

INSTRUCTIONS
