#!/bin/bash
set -eux
export LOTUS_PATH=/mnt/lotus-data

# we have just synced the chain, now we are behind and will be catching up
# profile the next ten minutes of cpu time
# (ten minutes was chosen a balance of not taking too long and getting enough consistent data)
timeout 10m  ./lotus daemon   --pprof pprof.out

# could add more focus areas here if req'd
go tool pprof -svg -focus=ApplyMessage -relative_percentages pprof.out
go tool pprof -svg -nodecount=500 -relative_percentages pprof.out
# this creates files
# profile001.svg  and
# profile002.svg which we will scp over
