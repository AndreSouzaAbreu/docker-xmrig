#!/bin/bash

function update_bashrc()
{
  echo -e "export TERM='linux'
alias q='exit'
alias v='vim'
alias v.='vim .'
alias dup='docker-compose up -d'
alias ddown='docker-compose down'" >> ~/.bashrc
  source ~/.bashrc
}

function install_docker()
{
  sudo apt update -y
  sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
  sudo apt update -y
  sudo apt install -y docker-ce
  sudo usermod -aG docker ${USER}
}

function install_docker_compose()
{
  sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose
  sudo chmod +x /usr/bin/docker-compose
}

function clone_xmrig()
{
  cd ${HOME} && git clone https://gitlab.com/andresouzaabreu/docker-xmrig
  echo -e "WALLET=your_wallet_address
POOL=pool.supportxmr.com:7777
WORKER_NAME=your_worker_name" > ${HOME}/docker-xmrig/.env
}

function main()
{
  update_bashrc
  install_docker
  install_docker_compose
  clone_xmrig
}

main
