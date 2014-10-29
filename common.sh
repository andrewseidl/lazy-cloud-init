#!/bin/sh

getKeys(keyurl) {
  if [ ! -d $HOME/.ssh ] ; then
    mkdir $HOME/.ssh
    chmod 600 $HOME/.ssh
  fi

  curl $keyurl >> $HOME/.ssh/authorized_keys
  chmod 600 $HOME/.ssh/authorized_keys
}
