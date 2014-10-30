#!/bin/sh

PKGMGR="echo FIXME "

update_package_list() {
  $PKGMGR update
}

upgrade_packages() {
  $PKGMGR upgrade
}

# ideally have a map between general package names and distro-specific ones
__install_package() {
  $PKGMGR install $@
}


# begin wrappers

__install_network_utils() {
  __install_package wget dns-utils
}

__install_sys_utils() {
  __install_package vim tmux mlocate speedtest-cli
}

__install_dev_utils() {
  __installPackage base-devel vim git
}

#begin public functions

install_utils() {
  __install_dev_utils
  __install_network_utils
  __install_sys_utils
}

add_user() {
  useradd -m $1
}

clone_dotfiles() {
  cd ~$1
  git clone $2 .dotfiles
  HOME=~$1 .dotfiles/script/bootstrap
}
