#!/bin/bash
set -eux
export LOTUS_PATH=/mnt/lotus-data

# we have just synced the chain, now we are behind and will be catching up
# profile the next ten minutes of cpu time
# (ten minutes was chosen a balance of not taking too long and getting enough consistent data)
timeout 10m  /mnt/lotus/lotus daemon   --pprof pprof.out || true

#make sure lotus exits
sleep 2m

#make sure lotus starts
/mnt/lotus/lotus daemon --bootstrap=false &
sleep 2m

/mnt/lotus/lotus chain export --recent-stateroots=900 --skip-old-msgs /mnt/lotus-data/chain_snapshot.car

