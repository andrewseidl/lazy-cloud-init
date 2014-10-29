#!/bin/sh

getKeys() {
  KEYURL=$1
  PREF=${2:=$HOME}
  if [ ! -d $PREF/.ssh ] ; then
    mkdir $PREF/.ssh
    chmod 600 $PREF/.ssh
  fi

  curl "$KEYURL" >> $PREF/.ssh/authorized_keys
  chmod 600 $PREF/.ssh/authorized_keys
}
