#!/bin/sh

DEBUG=${DEBUG:=true}
GHUSER=${GHUSER:="andrewseidl"}
KEYURL=${KEYURL:="https://github.com/$GHUSER.keys"}
REPOURL="https://raw.githubusercontent.com/andrewseidl/lazy-cloud-init/master/"

# Figure out our distro
detectDistro() {
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

# Begin common functions

# Download keys from the given url and place in authorized_keys
# 1: keyurl, required
# 2: home directory, optional
#TODO change ownership
getKeys() {
  KEYURL=$1
  HOME1=${2:=$HOME}
  if [ ! -d $HOME1/.ssh ] ; then
    mkdir $HOME1/.ssh
    chmod 600 $HOME1/.ssh
  fi

  curl "$KEYURL" >> $HOME1/.ssh/authorized_keys
  chmod 600 $HOME1/.ssh/authorized_keys
}

detectDistro
DISTSH="$DIST.sh"

if [ $DEBUG != true ] ; then
  curl -O $REPOURL/$DISTSH
  chmod +x $DISTSH
fi

source $DISTSH

init

echo $KEYURL
