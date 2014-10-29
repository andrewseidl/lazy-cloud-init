#!/bin/sh

getKeys() {
  KEYURL=$1
  if [ ! -d $HOME/.ssh ] ; then
    mkdir $HOME/.ssh
    chmod 600 $HOME/.ssh
  fi

  curl "$KEYURL" >> $HOME/.ssh/authorized_keys
  chmod 600 $HOME/.ssh/authorized_keys
}
