#!/usr/bin/env bash

NEWUSER=${NEWUSER:="andrew"}

DEBUG=${DEBUG:=false}
GHUSER=${GHUSER:="andrewseidl"}
KEYURL=${KEYURL:="https://github.com/$GHUSER.keys"}
DOTFILESURL=${KEYURL:="https://github.com/$GHUSER/dotfiles"}
REPOURL="https://raw.githubusercontent.com/andrewseidl/lazy-cloud-init/master/"

# Figure out our distro
detect_distro() {
  OS=`uname`
  DIST="unknown"

  if [ "${OS}" = "Linux" ] ; then
    if [ -f /etc/redhat-release ] ; then
      DIST="rh" # includes fedora?
    elif [ -f /etc/arch-release ] ; then
      DIST="arch"
    elif [[ $( grep /etc/os-release -e debian ) ]] ; then
      DIST="debian"
    elif [[ $( grep /etc/os-release -e amzn ) ]] ; then
      DIST="rh" # actually Amazon
    fi
  elif [ "${OS}" = "Darwin" ] ; then
    DIST="darwin"
  elif [ "${OS}" = "FreeBSD" ] ; then
    DIST="freebsd"
  fi
  readonly DIST
}

# Common functions

# Download keys from the given url and place in authorized_keys
# 1: keyurl, required
# 2: username, optional
get_keys() {
  KEYURL=$1
  KEYUSER=$2
  KEYUSER=${KEYUSER:=$USER}
  USERHOME=$(eval echo ~$KEYUSER)
  if [ ! -d $USERHOME/.ssh ] ; then
    mkdir $USERHOME/.ssh
    chmod 700 $USERHOME/.ssh
  fi

  curl "$KEYURL" >> $USERHOME/.ssh/authorized_keys
  chmod 600 $USERHOME/.ssh/authorized_keys
  chown -R $KEYUSER $USERHOME/.ssh
}

# download and configure dotfiles
clone_dotfiles() {
  cd ~$1
  git clone $2 .dotfiles
  HOME=~$1 .dotfiles/script/bootstrap
}


# get distro-specific config script

detect_distro
DISTSH="$DIST.sh"

if [ $DEBUG != true ] ; then
  curl -O $REPOURL/$DISTSH
  chmod +x $DISTSH
fi


# Let's begin
source ./$DISTSH

if [ $USER = "root" ] ; then
  update_package_list
  upgrade_packages
  install_utils

  add_user $NEWUSER
  get_keys $KEYURL $NEWUSER
fi

get_keys $KEYURL
