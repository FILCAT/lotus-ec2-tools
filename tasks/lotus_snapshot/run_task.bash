#!/bin/bash
set -eux
export LOTUS_PATH=/mnt/lotus-data

# we have just synced the chain, now we are behind and will be catching up
# profile the next ten minutes of cpu time
# (ten minutes was chosen a balance of not taking too long and getting enough consistent data)
timeout 10m  /mnt/lotus/lotus daemon   --pprof pprof.out || true

#make sure lotus exits
sleep 2m

#abstraction leak
sudo apt-get install -y pv
lotus chain export --recent-stateroots=1 --skip-old-msgs |pv> /mnt/lotus-data/chain_snapshot.car

