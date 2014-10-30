#!/bin/sh

PKGMGR="pacman --noconfirm"

update_package_list() {
  $PKGMGR -Syy
}

upgrade_packages() {
  $PKGMGR -Syu
}

# ideally have a map between general package names and distro-specific ones
__install_package() {
  $PKGMGR -S $@
}


# begin wrappers

__install_network_utils() {
  __install_package wget dnsutils
}

__install_sys_utils() {
  __install_package vim tmux mlocate speedtest-cli
}

__install_dev_utils() {
  __install_package base-devel vim git
}

__install_yaourt() {
  __install_dev_utils
  __install_network_utils

  __install_package yajl

  wget https://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz
  wget https://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz
  tar xvf package-query.tar.gz
  tar xvf yaourt.tar.gz
  cd package-query
  makepkg -i --asroot --noconfirm
  cd ../yaourt
  makepkg -i --asroot --noconfirm

  PKGMGR="yaourt --noconfirm"
}


#begin public functions

install_utils() {
  __install_yaourt
  __install_sys_utils
}

add_user() {
  useradd -m $1
}
