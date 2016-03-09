#!/bin/bash

set -e

cat <<-EOS >/etc/profile.d/vagrant.sh
 	export BIND_ADDR=0.0.0.0
EOS
chmod +x /etc/profile.d/vagrant.sh

cd /vagrant

export PG_VERSION=9.3

to_install=(
	build-essential
	git-core
	libgmp-dev
	libpq-dev
	"postgresql-$PG_VERSION"
	"postgresql-contrib-$PG_VERSION"
)

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -y upgrade
apt-get -y install "${to_install[@]}"

bin/setup-postgresql.sh
bin/setup-rvm.sh

sudo -iu vagrant bash <<-END
	cd /vagrant
	bin/setup
END
