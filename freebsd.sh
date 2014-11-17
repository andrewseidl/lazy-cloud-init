#!/usr/bin/env bash

PKGMGR="pkg"

update_package_list() {
  $PKGMGR update -y
}

upgrade_packages() {
  $PKGMGR upgrade -y
}

# ideally have a map between general package names and distro-specific ones
__install_package() {
  packages=()
  
  $PKGMGR install -y ${packages[@]}
}

__remove_package() {
  $PKGMGR remove -y $@
}


# begin wrappers

__install_network_utils() {
  __install_package wget bind-tools
}

__install_sys_utils() {
  __install_package vim zsh tmux mlocate speedtest-cli
}

__install_dev_utils() {
  __install_package vim git
}

#begin public functions

install_utils() {
  __install_dev_utils
  __install_network_utils
  __install_sys_utils
}

add_user() {
  pw user add $1 -m
}
