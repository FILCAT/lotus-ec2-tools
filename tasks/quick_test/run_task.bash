#!/bin/bash
set -eux
export LOTUS_PATH=/mnt/lotus-data

# start lotus
$lotus_dir/lotus daemon &
pid=$!
sleep 5s

# read block header and height
blockHeader=$($lotus_command chain head | head -n1)
height=$($lotus_command chain get-block $($lotus_command chain head | head -n1)|jq '.Height')

# stop lotus
kill $pid
sleep 5s

# print block header and height which can be confirmed for correctness
echo "Blockheader - "$blockHeader
echo "Height -"$height
