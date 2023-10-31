#!/bin/bash
set -eux

cd /mnt/
git clone https://github.com/filecoin-project/lotus.git
cd lotus

BRANCH=${LOTUS_GIT_BRANCH:-master}
git switch $BRANCH
git submodule update

echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc && source ~/.bashrc
export PATH=$PATH:/usr/local/go/bin

mkdir -p /mnt/tmp
export TMPDIR=/mnt/tmp

# Set BRANCH to the value of LOTUS_NETWORK, or to 'mainnet' if LOTUS_NETWORK is not set
BRANCH=${LOTUS_NETWORK:-mainnet}

# Check the value of LOTUS_NETWORK and execute the appropriate make command(s)
if [ "$LOTUS_NETWORK" == "mainnet" ]; then
    make lotus lotus-shed lotus-bench
elif [ "$LOTUS_NETWORK" == "calibnet" ]; then
    make calibnet
else
    echo "Unrecognized LOTUS_NETWORK value: $LOTUS_NETWORK"
    exit 1
fi

