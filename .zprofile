
######################################
#
# aliases & functions
#
######################################

# Pip3 installs packages to here
export PATH="$PATH:/home/$USER/.local/bin"

# GITHUB
export GITHUB_USER=joematpal
export GITHUB_TOKEN=`cat ~/.gh_pat`

update_github_netrc () {
    local update_value="machine github.com login $GITHUB_USER password $GITHUB_TOKEN"

    if ! [ -f ~/.gh_pat ]; then 
        echo "empty github personal acces token"
        exit 1
    fi

    # TODO: this is missing an edge case where the file is created but the contents are empty
    if [ -f ~/.netrc ]; then
        echo "updating ~/.netrc"

        sed -i "s/^machine github.*$/$update_value/" ~/.netrc
    else
        echo "creating ~/.netrc"

        echo $update_value > ~/.netrc
    fi

}

# ZSH
alias zshconfig="code ~/.zshrc"
alias rezsh="source ~/.zshrc"

# Golang
alias mygo="$HOME/go/src/github.com/$GITHUB_USER"
alias ddl="$HOME/go/src/github.com/digital-dream-labs"
export GOVERSION=1.17.6
export PATH="$PATH:/usr/local/go-$GOVERSION/bin"
export GOPATH=~/go
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$GOBIN"

export GOPRIVATE="github.com/anki,github.com/digital-dream-labs"

# update_golang will try to remove any convention of /usr/local/go to /usr/local/go-X.X.X
# should correspond to the GOVERSION ENV set in .zprofile
# Examples:
# 1. update_golang 1.17.6
# 2. sed -i "s/export GOVERSION=1.16.12/export GOVERSION=1.17.6/" && update_golang
update_golang () {
    local goversion=$GOVERSION

    if ! [ -z ${1+x}  ]; then
        goversion=$1
    fi

    echo "installing gol@$goversion in /usr/local/go/$goversion"
    sudo apt remove --autoremove golang
    sudo rm -rf /usr/local/go-$goversion
    # note: removing here just as a precausion
    sudo rm -rf /usr/bin/go-$goversion
    sudo rm -rf /usr/bin/go
    sudo rm -rf /usr/local/go

    if ! [ -f ~/Downloads/go$goversion.linux-amd64.tar.gz ]; then
        curl https://dl.google.com/go/go$goversion.linux-amd64.tar.gz -o ~/Downloads/go$goversion.linux-amd64.tar.gz
    fi

    sudo mkdir -p /usr/local/go-$goversion

    sudo tar -C /usr/local -xzf ~/Downloads/go$goversion.linux-amd64.tar.gz --transform s/go/go-$goversion/

    sudo chown -R $USER /usr/local/go-$goversion
    
    rm ~/Downloads/go$goversion.linux-amd64.tar.gz

    if [ $GOVERSION != $goversion ]; then
        echo "update GOVERSION to $goversion in .zprofile"
    fi
}

# update_go_alternative lets to smart switch between versions
# will try to replace the GOVERSION ENV in .zprofile
update_go_alternatives () {
    local goversion=$GOVERSION
    if ! [ -z ${1+x}  ]; then
        goversion=$1
    fi

    sed -i "s/^export GOVERSION=.*/export GOVERSION=$goversion/" ~/.zprofile

    if [ -d /usr/local/go/$goversion ]; then
        update_golang $goversion
    fi
}


# Kubernetes
export KUBE_EDITOR="nano"
alias k="kubectl"
alias knile="kubectl --kubeconfig=/home/$USER/.kube/nile/config"

# Dart/Flutter
alias mydart="$HOME/dart/src/github.com/$GITHUB_USER"
export PATH="$PATH:$HOME/flutter/bin"

# Node.js/Javascript
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias myjs="$HOME/js/src/github.com/$GITHUB_USER"
alias ddljs="$HOME/js/src/github.com/digital-dream-labs"

# Docker - Podman
alias docker="podman"
alias dk="podman"
alias pd="podman"
alias dcompose="podman-compose"
alias docker-compose="podman-compose"

## this one is not needed for macos
alias open="xdg-open"

# AWS

######################################
#
# general functions
#
######################################

trim_left () {
    echo "${1#$'$2'}"
}

trim_right () {
    echo "${1/%$2}"
}

last_word () {
    echo "${1##* }"
}

first_word () {
    echo "${1% *}"
}

# echoalias echos the value that an alias is assigned to
echoalias () {
    local which_result replace
    which_result=`which $1`

    replace="$1:\saliased\sto\s"

    echo `echo $which_result | sed "s/$replace//"`
}