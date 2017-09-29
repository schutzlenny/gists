#!/usr/bin/env bash
INSTALL_PATH="$1"
REPO_VERSION="${2-develop}"

set -e

if [ -z "$INSTALL_PATH" ]; then
    echo "ERR: No install path specified, please provide it as the first argument to this script" >&2
    exit 1
fi

INSTALL_PATH="${INSTALL_PATH/#~/$HOME}"
CHECKOUT_PATH="$INSTALL_PATH/src/sisu.sh"

echo
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo
echo " (╯°□°）╯︵ ┻━┻ Workspace omnibus installer"
echo
echo " Install path:  $INSTALL_PATH"
echo " Checkout path: $CHECKOUT_PATH"
echo " Version:       $REPO_VERSION"
echo
echo
echo " Do you wish to continue?"
echo " Press any key to continue or [Ctrl^C] to abort"
echo
read -n1 -s
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo

mkdir -p "$CHECKOUT_PATH"
cd "$CHECKOUT_PATH"

git clone git@github.com:simplesurance/sisu.git --branch "$REPO_VERSION" .
cd workspace
make
make init
