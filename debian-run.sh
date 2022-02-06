#! /bin/bash
source ./run.conf
source .zprofile

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
echo $GENESIS_GOLANG
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

    echo $mydart
    # mkdir -p $mydart
    
    git clone https://github.com/flutter/flutter.git ~/flutter
    flutter doctor
fi

## OpenJDK

######################################
#
# Development Utilities - Linux
#
######################################

## Backup Solution - restic

## Bluetooth

## C build tools

## AWS

## Kubenetes

## Terraform

## Docker - Podman

if $GENESIS_PODMAN; then
    echo "Installing Podman"
    sudo apt autoremove -y docker.io docker runc
    sudo apt install -y podman
fi

## .netrc

######################################
#
# Applications - Desktop Environment
#
######################################

## VS Code

## Android Studio

## Slack

## Lauch Keyboard 

## Gnome Tweeks

## Bitwardend

## Tilix - manually change the super + T to open Tilix instead of default terminal

## Discord