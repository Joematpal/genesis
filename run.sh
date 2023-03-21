#! /bin/bash -e

[[ -f "~/.zprofile" ]] && source .zprofile
source ./run.conf

if ! $GENESIS_RUN; then
    echo "please enable genesis, any other features, in run.conf"
    exit 1
fi


if ! [ -z $GENESIS_PROFILE ]; then
    # NOTE: these aliases will not work unless you source them in the .zshrc file
    echo "setting profile: $GENESIS_PROFILE"

    if ! [ -z $GITHUB_USER ]; then
        # TODO: should with work with other peoples .zprofile?
        echo "setting github user: $GITHUB_USER"

        sed -i "s/export GITHUB_USER=.*/export GITHUB_USER=$GITHUB_USER/" $GENESIS_PROFILE
    fi

    # make the aliases directory
    [[ -f "~/.zprofile" ]] && rm ~/.zprofile

    # Add in the aliases
    cp $GENESIS_PROFILE ~/.zprofile
    source ~/.zprofile
fi

# Add in the .zshrc file
[[ -f "~/.zshrc" ]] && rm ~/.zshrc

cp ./.zshrc ~/.zshrc

echo $SHELL

if ! [ -x "$(command -v lsb_release)" ]; then
   sudo apt install lsb-core
fi

release=`lsb_release -i`

distributor_id=`trim_left "$release" "Distributor ID:"`
distributor=`last_word $distributor_id`

# DISTRO CHECKER
case ${distributor,,} in

  pop | ubuntu | debian)
    echo "installing for debian based systems"
    ./debian-run.sh
    ;;

  *)
    exit 1
    ;;
esac
