#!/bin/bash

set -e

PG_CONF="/etc/postgresql/$PG_VERSION/main/postgresql.conf"
PG_HBA="/etc/postgresql/$PG_VERSION/main/pg_hba.conf"

sed -ie "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" "$PG_CONF"
echo "client_encoding = utf8" >> "$PG_CONF"

cat <<-EOF > "$PG_HBA"
  # TYPE  DATABASE USER      ADDRESS      METHOD
  local   all      postgres  peer
  local   all      all       md5
  host    all      all       127.0.0.1/32 md5
  host    all      all       ::1/128      md5
  host    all      all       all          md5
EOF

service postgresql restart

sudo -u postgres psql -x -v ON_ERROR_STOP=1 <<-END
  CREATE USER wiki
  WITH
    PASSWORD 'dbpass'
    SUPERUSER;
END
