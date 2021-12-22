#!/usr/bin/env bash

set -eu -o pipefail

brew install colima docker make mkcert mysql-client
colima start
sudo mkcert -install
