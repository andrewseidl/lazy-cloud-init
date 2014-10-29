#!/bin/sh

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

detectDistro
echo $DIST
