#!/bin/bash
set -eux

lotus_dir=/mnt/data/state-invariants-check/lotus

export LOTUS_PATH=/mnt/data/lotus
$lotus_dir/lotus daemon --bootstrap=false &
pid=$!
sleep 5s
#todo if needed, loop instead of arbitrary sleep

ParentStateRoot=$(./lotus/lotus chain get-block $(./lotus/lotus chain head | head -n1)|jq '.ParentStateRoot["/"]' | tr -d '"' )
height=$(./lotus/lotus chain get-block $(./lotus/lotus chain head | head -n1)|jq '.Height')

kill $pid
sleep 5s
#todo if needed, loop instead of arbitrary sleep

$lotus_dir/lotus-shed check-invariants --repo=$LOTUS_PATH "$ParentStateRoot" "$height" | tee check-invariants.out

