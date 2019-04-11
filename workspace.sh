#!/usr/bin/env bash
INSTALL_PATH="$1"
REPO_VERSION="${2-develop}"

set -eo pipefail

if [ -z "$INSTALL_PATH" ]; then
    echo "ERR: No install path specified, please provide it as the first argument to this script" >&2
    exit 1
fi

INSTALL_PATH="${INSTALL_PATH/#~/$HOME}"
CHECKOUT_PATH="$INSTALL_PATH/src/sisu.sh"

cat <<'EOF'
 _       __           __
| |     / /___  _____/ /___________  ____ _________
| | /| / / __ \/ ___/ //_/ ___/ __ \/ __ `/ ___/ _ \
| |/ |/ / /_/ / /  / ,< (__  ) /_/ / /_/ / /__/  __/
|__/|__/\____/_/  /_/|_/____/ .___/\__,_/\___/\___/
                           /_/ simplesurance GmbH

EOF
echo " $(uname -s)/$(uname -r) @ $(uname -m)"
echo
echo " * Install path     $INSTALL_PATH"
echo " * Checkout path    $CHECKOUT_PATH"
echo " * Version          $REPO_VERSION"
echo
echo
echo " The installer script will now clone simplesurance's monolithic"
echo " repository to $CHECKOUT_PATH and proceed with installing the"
echo " minimum requirements to run the development stack."
echo
echo " Do you wish to continue?"
echo " Press any key to continue or [Ctrl^C] to abort"
echo
read -n1 -s
echo
echo

mkdir -p "$CHECKOUT_PATH"
cd "$CHECKOUT_PATH"

# only clone if we haven't cloned already
if [ -d .git ]; then
    echo "WARN: Repository clone seems to exist already, skipping..." >&2
else
    git clone git@github.com:simplesurance/sisu.git --branch "$REPO_VERSION" .
fi

cd workspace
make clean # remove any leftovers from previous installations, if any
make
make init
