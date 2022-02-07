#! /bin/bash
source ./run.conf
source .zprofile

mkdir -p ~/bin

######################################
#
# Shell
#
######################################

if $GENESIS_ZSH; then
    sudo apt install zsh
fi

if $GENESIS_OMZ; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

######################################
#
# Aliases
#
######################################

######################################
#
# Qualify of Life
#
######################################

# Hostname - https://www.nasa.gov/missions or constellation or planets 
hostnamectl set-hostname $HOSTNAME

######################################
#
# Programming Languages
#
######################################

## Golang
if $GENESIS_GOLANG; then
    update_go_alternatives
fi

## Rust
if $GENESIS_RUST; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env
    rustup update
fi

## Python

if $GENESIS_PYTHON3; then
    echo "Installing Python2"
    sudo apt autoremove python3.9 -y
    sudo add-apt-repository ppa:deadsnakes/ppa -y
    sudo apt update -y

    # TODO: be sure to keep this updated
    sudo apt install python3.9 -y
    sudo ln -s /usr/bin/python3.9 /usr/bin/py
    sudo ln -s /usr/bin/python3.9 /usr/bin/python
    
    sudo apt install python3-pip
    # TODO: this might need venv
fi

if $GENESIS_PYTHON2; then
    echo "Installing Python2"

    sudo apt autoremove python2.7 -y
    sudo add-apt-repository ppa:deadsnakes/ppa -y
    sudo apt update -y
    
    sudo apt install python2.7 -y

    sudo ln -s /usr/bin/python2.7 /usr/bin/python2
    sudo ln -s /usr/bin/python2.7 /usr/bin/py2

    curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip.py

    # this gets installed to /usr/local/bin/; idk why
    sudo python2 get-pip.py
    rm get-pip.py

    sudo rm /usr/local/bin/pip

    # TODO: this might need venv
fi

## Node.js
if $GENESIS_NODEJS; then
    echo "Installing NodeJS"
    sudo apt autoremove -y nodejs

    mkdir -p $myjs
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
    nvm install node

    # TODO: this might need npm
fi

## Flutter/Dart

if $GENESIS_FLUTTER; then
    echo "Installing Flutter/Dart"
    
    git clone https://github.com/flutter/flutter.git ~/flutter
    flutter doctor
fi

## OpenJDK

## Github CLI

if $GENESIS_GITHUB; then
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/etc/apt/trusted.gpg.d/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/trusted.gpg.d/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update
    sudo apt install gh
    
fi

######################################
#
# Development Utilities - Linux
#
######################################

## Backup Solution - restic

## Bluetooth

## C build tools

## AWS
if $GENESIS_AWS; then
    echo "Installing AWS CLI v2"

    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install

fi

## Kubenetes

if $GENESIS_KUBERNETES; then
    echo "Installing kubectl"
    sudo apt update
    sudo apt install -y apt-transport-https ca-certificates curl
    sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

    echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

    sudo apt update
    sudo apt install -y kubectl

    ## To installed the latest.
    # curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    # curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
    
    # isCheckSumValid=$(echo -n "`cat kubectl.sha256` kubectl" | sha256sum -c)

    # echo "check sum: $isCheckSumValid"
    
    # if [ `trim_left $isCheckSumValid "kubectl: "` != "OK" ]; then
    #     sudo mv ./kubectl ~/bin/kubectl

    #     echo "Kubernetes Insalled Successfully"
    # else
    #     rm ./kubectl
    #     echo "Kubernetes Install Failed"
    # fi

fi

## Terraform

if $GENESIS_TERRAFORM; then

    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/terraform-archive-keyring.gpg

    echo "deb [signed-by=/usr/share/keyrings/terraform-archive-keyring.gpg] https://apt.releases.hashicorp.com focal main" | sudo tee /etc/apt/sources.list.d/terraform.list

    sudo apt update -y
    sudo apt install terraform -y

fi

## Docker - Podman

if $GENESIS_PODMAN; then
    echo "Installing Podman"

    sudo apt autoremove -y docker.io docker runc
    sudo apt install -y podman
fi

## .netrc

######################################
#
# Applications - Desktop Environment Gnome
#
######################################

## VS Code

## Android Studio

## Slack

## Launch Keyboard Configurator 

## Gnome Tweeks

## Bitwarden

## Tilix - manually change the super + T to open Tilix instead of default terminal

## Discord