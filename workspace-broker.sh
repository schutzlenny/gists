#!/usr/bin/env bash

INSTALL_PATH="$1"
BROKER_VERSION="${2-develop}"
SISU_VERSION="${3-develop}"

set -e

if [ -z "$INSTALL_PATH" ]; then
    echo "ERR: No install path specified, please provide it as the first argument to this script" >&2
    exit 1
fi

INSTALL_PATH="${INSTALL_PATH/#~/$HOME}"
CHECKOUT_PATH="$INSTALL_PATH/src/sisu.sh"

mkdir -p ${INSTALL_PATH}/src/sisu.sh # broker repo
mkdir -p ${INSTALL_PATH}/src/sisu # sisu sparse checkout

cd ${INSTALL_PATH}

(
    cd src/sisu \
      && git init \
      && git remote add origin git@github.com:simplesurance/sisu.git \
      && git config core.sparseCheckout true \
      && echo "workspace/*" >> .git/info/sparse-checkout \
      && git pull --depth 1 origin ${SISU_VERSION} \
      && git checkout ${SISU_VERSION}
)

(
    cd src/sisu.sh \
      && git clone --depth 1 -b ${BROKER_VERSION} git@github.com:simplesurance/garden.git . \
      && ln -s ../sisu/workspace workspace
)

export GLOBAL_SKIP_PROMPTS=y

cd src/sisu.sh/workspace
make
helper/bin/workspace init
