#!/bin/bash

set -e

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

wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh

bin/setup-postgresql.sh
bin/setup-rvm.sh

sudo -iu vagrant bash <<-END
	cd /vagrant
	bin/setup
END
