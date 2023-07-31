#!/bin/bash
set -eux
export LOTUS_PATH=/mnt/lotus-data

# we have just synced the chain, now we are behind and will be catching up
# profile the next ten minutes of cpu time
# (ten minutes was chosen a balance of not taking too long and getting enough consistent data)
timeout 10m  /mnt/lotus/lotus daemon   --pprof pprof.out || true

#make sure lotus exits
sleep 2m

#see if this fixes problem
export PATH=$PATH:/usr/local/go/bin
# could add more focus areas here if req'd
go tool pprof -svg -focus=ApplyMessage -relative_percentages pprof.out
go tool pprof -svg -nodecount=500 -relative_percentages pprof.out
echo "list ApplyMessage" | go tool pprof pprof.out > ApplyMessage.txt
go tool pprof -focus=ApplyMessage -top -relative_percentages pprof.out  > RelativePercentages.txt


# this creates files
# profile001.svg
# profile002.svg
# ApplyMessage.txt
# RelativePercentages.txt
# which we will scp over
