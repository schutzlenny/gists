#!/usr/bin/env bash
INSTALL_PATH="$1"
REPO_VERSION="${2-develop}"

set -e

if [ -z "$INSTALL_PATH" ]; then
    echo "No install path specified, please provide it as the first argument to this script"
    exit 1
fi

CHECKOUT_PATH="$INSTALL_PATH/src/sisu.sh"

echo "INSTALL PATH:  $INSTALL_PATH"
echo "VERSION:       $REPO_VERSIONTH
echo "CHECKOUT PATH: $CHECKOUT_PATH"
echo

read -p "Do you wish to continue? [Y/n] " confirm

if [[ "$confirm" == "n" || "$confirm" == "N" ]]; then
    exit 0
fi

mkdir -p "$CHECKOUT_PATH"
cd "$CHECKOUT_PATH"
git clone git@github.com:simplesurance/sisu.git --branch "$REPO_VERSION" .

cd workspace
make
make init
