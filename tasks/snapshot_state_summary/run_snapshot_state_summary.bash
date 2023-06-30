#!/bin/bash
set -eux

#Temporyary until branch is merged merge:
cd /mnt/data/state-invariants-check/lotus/
git checkout feat/stat-snapshot
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc && source ~/.bashrc
export PATH=$PATH:/usr/local/go/bin
mkdir -p /mnt/data/tmp
export TMPDIR=/mnt/data/tmp
make lotus lotus-shed


export LOTUS_PATH=/mnt/data/lotus

/mnt/data/state-invariants-check/lotus/lotus-shed --repo=$LOTUS_PATH stat-snapshot
