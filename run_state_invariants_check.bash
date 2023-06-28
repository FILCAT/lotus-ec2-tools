#!/bin/bash
set -eux

lotus_dir=/mnt/data/state-invariants-check/lotus
lotus_command=$lotus_dir/lotus

export LOTUS_PATH=/mnt/data/lotus
$lotus_dir/lotus daemon --bootstrap=false &
pid=$!
sleep 5s
#todo if needed, loop instead of arbitrary sleep

ParentStateRoot=$($lotus_command chain get-block $($lotus_command chain head | head -n1)|jq '.ParentStateRoot["/"]' | tr -d '"' )
height=$($lotus_command chain get-block $($lotus_command chain head | head -n1)|jq '.Height')

kill $pid
sleep 5s
#todo if needed, loop instead of arbitrary sleep

$lotus_dir/lotus-shed check-invariants --repo=$LOTUS_PATH "$ParentStateRoot" "$height" | tee check-invariants.out

