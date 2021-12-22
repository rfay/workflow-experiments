#!/usr/bin/env bash

set -eu -o pipefail

brew unlink golang || true
brew install docker golang mkcert mysql-client
brew install colima --HEAD
brew link --overwrite mysql-client golang

# This command allows adding CA (in mkcert, etc) without the popup trust prompt
# Mentioned in https://github.com/actions/virtual-environments/issues/4519#issuecomment-970202641
sudo security authorizationdb write com.apple.trust-settings.admin allow
colima start
mkcert -install
