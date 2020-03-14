#!/usr/bin/env bash
set -eo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"

parse_args() {
    INSTALL_PATH="${1-$SCRIPT_DIR}"
    REPO_VERSION="${2-develop}"

    INSTALL_PATH="${INSTALL_PATH/#~/$HOME}"
    CHECKOUT_PATH="$INSTALL_PATH/src/sisu.sh"

    if [ -z "$INSTALL_PATH" ]; then
        echo "ERR: No install path specified, please provide it as the first argument to this script" >&2
        exit 1
    fi
}

function init() {
    if [ ! -d "$INSTALL_PATH" ]; then
        echo "WARN: Install path does not exist, creating..."
        mkdir -p "$INSTALL_PATH"
    fi

    if [ ! -d "$CHECKOUT_PATH" ]; then
        mkdir -p "$CHECKOUT_PATH"
    fi

    # resolve paths
    INSTALL_PATH="$(cd "$INSTALL_PATH"; pwd -P)"
    CHECKOUT_PATH="$(cd "$CHECKOUT_PATH"; pwd -P)"
}

function banner() {
    echo
    echo ".======================== WORKSPACE INSTALLER =========================="
    echo "|"
    echo "|"
    echo "|  Install path     $INSTALL_PATH"
    echo "|  Checkout path    $CHECKOUT_PATH"
    echo "|  Version          $REPO_VERSION"
    echo "|"
    echo "|"
    echo "|-----------------------------------------------------------------------"
    echo "|"
    echo "| The installer script will now proceed and:"
    echo "|"
    echo "| * clone the monorepo, ie: https://github.com/simplesurance/sisu"
    echo "| * ensure your environment is properly configured"
    echo "| * ensure your system meets the minimum requirements"
    echo "| * install the required dependencies to run the dev stack"
    echo "|"
    echo "|"
    echo "| If the installation fails just re run this script to resume it!"
    echo "|"
    echo "|"
    echo "| Coffee? Mate?"
    echo "| Make yourself confortable, this might take a while!"
    echo "|"
    echo "'-----------------------------------------------------------------------"
    echo
    prompt_continue
    echo
    echo
}

function prompt_continue() {
    echo " Do you wish to continue?"
    echo " Press any key to continue or [Ctrl^C] to abort"
    echo
    read -n1 -s
}

function checkout() {
    # only clone if we haven't cloned already
    if [ -d "${CHECKOUT_PATH}/.git" ]; then
        echo "WARN: Repository seems to be cloned already, skipping..." >&2
    else
        git clone git@github.com:simplesurance/sisu.git --branch "$REPO_VERSION" "$CHECKOUT_PATH"
    fi
}

function install() {
    (cd "${CHECKOUT_PATH}/workspace" && make)
}


parse_args "$@"
banner
init
checkout
install

