#!/bin/bash
set -eux
git clone https://github.com/filecoin-project/lotus.git
cd lotus

# XXX eventually do not need
git checkout feat/stat-snapshot

echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc && source ~/.bashrc
make calibnet

# XXX change from calibnet
#make lotus lotus-shed
