#!/usr/bin/env bash
set -eo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"
SCRIPT_FILE="${SCRIPT_DIR}/$(basename "$0")"

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
    echo
    echo " -> INFO: Initializing installer..."

    if [ ! -d "$INSTALL_PATH" ]; then
        echo " -> INFO: Install path does not exist, creating..." >&2
        mkdir -p "$INSTALL_PATH"
    fi

    if [ ! -d "$CHECKOUT_PATH" ]; then
        echo " -> INFO: Checkout path does not exist, creating..." >&2
        mkdir -p "$CHECKOUT_PATH"
    fi

    # resolve paths
    INSTALL_PATH="$(cd "$INSTALL_PATH"; pwd -P)"
    CHECKOUT_PATH="$(cd "$CHECKOUT_PATH"; pwd -P)"

    echo " -> INFO: Starting installer..."
    echo
}

function banner() {
    cat <<EOF
.========================== WORKSPACE INSTALLER ============================
│
│  Install path:        $INSTALL_PATH
│  Checkout path:       $CHECKOUT_PATH
│  Repository version:  $REPO_VERSION
│  Installer version:   $(sha1sum "$SCRIPT_FILE" | awk '{print $1}')
│
├───────────────────────────────────────────────────────────────────────────
│
│
│ The installer script will now proceed and:
│
│ * clone the monorepo, ie: https://github.com/simplesurance/sisu
│ * ensure your environment is properly configured
│ * ensure your system meets the minimum requirements
│ * install the required dependencies to run the dev stack
│
│
│ IMPORTANT: If the installation fails just re run this script to resume it!
│
│ IMPORTANT: Be sure to read the instructions displayed at the end
│            of the installer script to finish your setup.
│
│
│ Coffee? Mate?
│ Make yourself confortable, this might take a while!
│
│
└────────────────────────────────────────────────────────────────────────────

EOF

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
        echo " -> WARN: Repository seems to be cloned already, skipping..." >&2
    else
        git clone git@github.com:simplesurance/sisu.git --branch "$REPO_VERSION" "$CHECKOUT_PATH"
    fi
}

function install() {
    (cd "${CHECKOUT_PATH}/workspace" && make)
}


parse_args "$@"
init
banner
checkout
install

