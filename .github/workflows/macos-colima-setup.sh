#!/usr/bin/env bash

set -eu -o pipefail

brew install docker mkcert mysql-client
brew install colima --HEAD
brew link mysql-client

# This command allows adding CA (in mkcert, etc) without the popup trust prompt
# Mentioned in https://github.com/actions/virtual-environments/issues/4519#issuecomment-970202641
sudo security authorizationdb write com.apple.trust-settings.admin allow
colima start
mkcert -install
