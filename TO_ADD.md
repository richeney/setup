# To Add

* Docker
* Go
* Kind

* azcopy
* helm
* kubectl
* dircolors ✅
* terraform
* packer
* vim ✅
* Create git and take list of git repos and clone

# sql

https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-tools?view=sql-server-2017

But curl the 20.04 version

## helm

$ curl -O https://get.helm.sh/helm-v3.4.2-linux-amd64.tar.gz
$ tar -zxvf helm-v3.4.2-linux-amd64.tar.gz
linux-amd64/
linux-amd64/helm
linux-amd64/README.md
linux-amd64/LICENSE
$ sudo mv linux-amd64/helm /usr/local/bin/helm
$ sudo chmod 755 /usr/local/bin/helm
$ sudo chown root:root /usr/local/bin

## docker

sudo apt install docker.io
sudo service docker start
sudo service docker status

https://docs.docker.com/install/linux/linux-postinstall/#manage-docker-as-a-non-root-user
sudo groupadd docker
sudo usermod -aG docker $USER
Log out and back in again
docker run hello-world

Fun containers to run interactively
docker run -it inutano/cmatrix
docker run -it jessfraz/hollywood

## Initialise Git ready for settings synced vscode use

```bash
git config --global user.name "Richard Cheney"
git config --global user.mail "richeney@microsoft.com"
git config --global credential.help store
git config --global credential.user richeney
```

## bashrc remaining

```bash
alias airs='az account set --subscription 2ca40be1-7e80-4f2b-92f7-06b2123a68cc; az account show'
alias vs='az account set --subscription 2d31be49-d959-4415-bb65-8aec2c90ba62; az account show'

export PATH=$PATH:/usr/local/go/bin:~/go/bin # Installed Go and docker and kind

alias re='clear'

# installed docker and kubectl
# sudo apt remove docker
# sudo apt install docker.io
# sudo systemctl enable --now docker
# sudo usermod -aG docker richeney
# sudo az aks install-cli

# Manually installed vault from https://releases.hashicorp.com/vault/

# Installed helm:
#   curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
#   chmod 700 get_helm.sh
#   ./get_helm.sh

# Installed git and GitHub CLI
# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
# sudo apt-add-repository https://cli.github.com/packages
# sudo apt update
# sudo apt install gh

# Installed go to /usr/local/go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export GOAZURERM=$GOPATH/src/github.com/terraform-providers/terraform-provider-azurerm
export PATH="$PATH:/usr/local/go/bin:$GOBIN"

## Other Cloud CLIs

```yaml
    - name: Install other cloud CLIs
      apt:
        name: "{{ packages }}"
        state: present
        update_cache: yes
      vars:
        packages:
          - awscli
          - google-cloud-sdk
    - name: Set gcloud to use python3
      lineinfile:
        path: ~richeney/.bashrc
        line: export CLOUDSDK_PYTHON=python3
```

## Install hugo

There will be an old version of hugo in the image. It's rubbish.

<https://github.com/gohugoio/hugo/releases>