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
echo "CHECKOUT PATH: $CHECKOUT_PATH"
echo "VERSION:       $REPO_VERSION"
echo

echo "Do you wish to continue?"
echo "Press any key to continue or [Ctrl^C] to abort"
echo
read -n1 -s

mkdir -p "$CHECKOUT_PATH"
cd "$CHECKOUT_PATH"
git clone git@github.com:simplesurance/sisu.git --depth 1 --branch "$REPO_VERSION" .

cd workspace
make
make init
