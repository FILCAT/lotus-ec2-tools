#!/bin/bash
set -eux


./lotus/lotus daemon --bootstrap=false &
pid=$!


ParentStateRoot=$(./lotus chain get-block $(./lotus chain head | head -n1)|jq '.ParentStateRoot["/"]' | tr -d '"' )
height=$(./lotus chain get-block $(./lotus chain head | head -n1)|jq '.Height')

# Checking if the process has exited and waiting if not
while kill -0 $pid > /dev/null 2>&1
do
  echo "Waiting for the process to end"
  sleep 1
done
echo "Process has ended"



./lotus-shed check-invariants $ParentStateRoot $height

