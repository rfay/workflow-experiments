#!/usr/bin/env bash

set -eu -o pipefail

brew install colima docker make mkcert mysql

mkcert -install

set +eu
