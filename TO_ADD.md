# To Add

* Docker
* Go
* Kind

* azcopy
* dircolors
* terraform
* packer
* vim

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

# cross-tenant

alias    citadel='az login --service-principal --user b377d441-7014-46fb-8ef2-13924bcf9149 --password NjxMutJZ5pWqxnA1pbylzZbpXf5PPlOBK6yL9wRfDzS4pS1Z4NeDVGOdhA6LKMkcPsTaot9LLi1lqUSFkdeygLE9hE3CdTZXx1EI6Nk7Lhw5Y4Fe4EEvES2Tedh23CCR --tenant f246eeb7-b820-4971-a083-9e100e084ed0'
alias lighthouse='az login --service-principal --user 592a86af-df75-41b9-a042-0a31dd6e1301 --password SGyUonk75DyS6lOFse8q7cdAi4sz75kVz3N33qs0rvNdFDAN2uYDbFc2EirDaEOZDfEoK0ACUSxZg5XTZ6ZKiIaP3IHHOKpWQRYrV5g9liU52PlxmE4ma5r1NTrw9RTC --tenant ce508eb3-7354-4fb6-9101-03b4b81f8c54'

# Decode JWT tokens
_decode_base64_url() {
  local len=$((${#1} % 4))
  local result="$1"
  if [ $len -eq 2 ]; then result="$1"'=='
  elif [ $len -eq 3 ]; then result="$1"'='
  fi
  echo "$result" | tr '_-' '/+' | base64 -d
}

# $1 => JWT to decode
# $2 => either 1 for header or 2 for body (default is 2)
jwt() { _decode_base64_url $(echo -n $1 | cut -d "." -f ${2:-2}) | jq .; }

```

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