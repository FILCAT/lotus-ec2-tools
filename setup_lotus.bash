#!/bin/bash
set -eux

cd /mnt/
git clone https://github.com/filecoin-project/lotus.git
cd lotus

BRANCH=${LOTUS_GIT_BRANCH:-master}
git switch $BRANCH

echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc && source ~/.bashrc
export PATH=$PATH:/usr/local/go/bin

mkdir -p /mnt/tmp
export TMPDIR=/mnt/tmp
make lotus lotus-shed lotus-bench
#make calibnet
