#!/bin/bash
set -eux
export LOTUS_PATH=/mnt/lotus-data

lotus_dir=/mnt/lotus
lotus_command=$lotus_dir/lotus
lotus_shed_command=$lotus_dir/lotus-shed

#Add your code here to execute your new task
#Pass data back through stdout


$lotus_command daemon --bootstrap=false &
pid=$!
sleep 5s
#todo if needed, loop instead of arbitrary sleep

ParentStateRoot=$($lotus_command chain get-block $($lotus_command chain head | head -n1)|jq '.ParentStateRoot["/"]' | tr -d '"' )
height=$($lotus_command chain get-block $($lotus_command chain head | head -n1)|jq '.Height')

kill $pid
sleep 5s


$lotus_shed_command check-invariants --repo=$LOTUS_PATH "$ParentStateRoot" "$height"



#get new state root after migration

$lotus_command daemon --bootstrap=false &
pid=$!
sleep 5s
#todo if needed, loop instead of arbitrary sleep

ParentStateRoot=$($lotus_command chain get-block $($lotus_command chain head | head -n1)|jq '.ParentStateRoot["/"]' | tr -d '"' )
height=$($lotus_command chain get-block $($lotus_command chain head | head -n1)|jq '.Height')

kill $pid
sleep 5s


$lotus_shed_command migrate-state --check-invariants --repo=$LOTUS_PATH  21 $ParentStateRoot
