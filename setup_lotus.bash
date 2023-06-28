#!/bin/bash
set -eux

cd /mnt/data/state-invariants-check
git clone https://github.com/filecoin-project/lotus.git
cd lotus

# XXX eventually do not need
#git checkout feat/stat-snapshot

echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc && source ~/.bashrc
export PATH=$PATH:/usr/local/go/bin

mkdir -p /mnt/data/tmp
export TMPDIR=/mnt/data/tmp

make lotus lotus-shed
#make calibnet
