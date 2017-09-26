#!/usr/bin/env bash
INSTALL_PATH="$1"
REPO_VERSION="${2-develop}"

set -e

if [ -z "$INSTALL_PATH" ]; then
    echo "No install path specified, please provide it as the first argument to this script"
    exit 1
fi

echo "INSTALL PATH: $INSTALL_PATH"
echo "VERSION:      $REPO_VERSION"
echo

mkdir -p "$INSTALL_PATH/src/sisu.sh"
git clone git@github.com:simplesurance/sisu.git --branch "$REPO_VERSION" "$INSTALL_PATH/src/sisu.sh"

cd "$INSTALL_PATH/src/sisu.sh/workspace"
make
