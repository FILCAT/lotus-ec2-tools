#!/bin/bash
set -eux

INSTANCE_PUBLIC_DNS="$1"

ssh -i  ~/.ssh/aws.pem  ubuntu@$INSTANCE_PUBLIC_DNS bash /mnt/data/state-invariants-check/node/lotus/start_node.bash 
