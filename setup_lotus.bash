#!/bin/bash
set -eux
git clone https://github.com/filecoin-project/lotus.git
cd lotus

# XXX eventually do not need
git checkout feat/stat-snapshot

echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc && source ~/.bashrc
export PATH=$PATH:/usr/local/go/bin

mkdir -p /mnt/data/tmp
export TMPDIR=/mnt/data/tmp
make calibnet

# XXX change from calibnet
#make lotus lotus-shed
