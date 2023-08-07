#!/bin/bash
set -eux

new_file="$1"

lotus_dir=/mnt/lotus
lotus_command=$lotus_dir/lotus

export LOTUS_PATH=/mnt/lotus-data
$lotus_dir/lotus daemon --bootstrap=false &
pid=$!
sleep 5s
#todo if needed, loop instead of arbitrary sleep

blockHeader=$($lotus_command chain head | head -n1)
height=$($lotus_command chain get-block $($lotus_command chain head | head -n1)|jq '.Height')

kill $pid
sleep 5s
#todo if needed, loop instead of arbitrary sleep

$lotus_dir/lotus-shed migrate-state --repo=$LOTUS_PATH 21 "$blockHeader"  | tee /mnt/$new_file
