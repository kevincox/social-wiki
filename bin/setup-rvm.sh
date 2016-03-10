#!/bin/bash

set -e

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

curl -fsSL https://get.rvm.io | bash

usermod -aG rvm vagrant

cat >/etc/rvmrc <<-END
  umask u=rwx,g=rwx,o=rx
  rvm_install_on_use_flag=1
END

. /etc/profile.d/rvm.sh

rvm install .
