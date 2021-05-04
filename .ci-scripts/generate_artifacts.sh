#!/bin/bash
# This script builds ddev artifacts and their sha256 hashes.
# First arg is the artifact directory

set -o errexit
set -o pipefail
set -o nounset

MKCERT_VERSION=v1.4.6
BUILD_IMAGE_TARBALLS=false

ARTIFACTS=${1:-/artifacts}
BASE_DIR=$PWD

mkdir -p $ARTIFACTS || (sudo mkdir -p $ARTIFACTS && sudo chmod 777 $ARTIFACTS)
export VERSION=$(git describe --tags --always --dirty)

# If the version does not have a dash in it, it's not prerelease,
# so build image tarballs
if [ "${VERSION}" = "${VERSION%%-*}" ]; then
    BUILD_IMAGE_TARBALLS=true
fi

BUILTPATH=.gotmp/bin/$(go env GOOS)_$(go env GOARCH)


# generate windows-amd64 tarball/zipball
pushd $BASE_DIR/.gotmp/bin/windows_amd64 >/dev/null
curl -sSL -o mkcert.exe https://github.com/drud/mkcert/releases/download/${MKCERT_VERSION}/mkcert-${MKCERT_VERSION}-windows-amd64.exe
tar -czf $ARTIFACTS/ddev_windows-amd64.$VERSION.tar.gz ddev.exe *completion*.sh mkcert.exe
if [ -d chocolatey ]; then
    tar -czf $ARTIFACTS/ddev_chocolatey_amd64-.$VERSION.tar.gz chocolatey
fi
popd >/dev/null
