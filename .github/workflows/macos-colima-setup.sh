#!/usr/bin/env bash

set -eu -o pipefail

brew install colima docker mkcert mysql-client
brew link mysql-client
sudo ls
colima start
sudo mkcert -install
