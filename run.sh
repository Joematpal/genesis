#! /bin/bash -e

source .zprofile
source ./run.conf

if ! $GENESIS_RUN; then
    echo "please enable genesis, any other features, in run.conf"
    exit 1
fi


if ! [ -z $GENESIS_PROFILE ]; then
    # NOTE: these aliases will not work unless you source them in the .zshrc file

    if ! [ -z $GITHUB_USER ]; then
        # TODO: should with work with other peoples .zprofile?

        sed -i "s/export GITHUB_USER=.*/export GITHUB_USER=$GITHUB_USER/" $GENESIS_PROFILE
    fi

    # make the aliases directory
    rm ~/.zprofile

    # Add in the aliases
    cp $GENESIS_PROFILE ~/.zprofile
fi

# Add in the .zshrc file
rm ~/.zshrc
cp ./.zshrc ~/.zshrc

release=`lsb_release -i`

distributor_id=`trim_left "$release" "Distributor ID:"`
distributor=`last_word $distributor_id`

case ${distributor,,} in

  pop | ubuntu | debian)
    echo okay!
    ./debian-run.sh
    ;;

  *)
    exit 1
    ;;
esac
