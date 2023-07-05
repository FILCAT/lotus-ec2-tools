#!/bin/bash
set -eux

INSTANCE_PUBLIC_DNS="$1"

new_file="check-invariants-`date +"%Y-%m-%d-%H-%M-%S"`.out"
ssh -i  ~/.ssh/aws.pem  ubuntu@$INSTANCE_PUBLIC_DNS bash /mnt/data/state-invariants-check/tasks/state_invariants_check/run_state_invariants_check.bash $new_file
scp -i  ~/.ssh/aws.pem  ubuntu@$INSTANCE_PUBLIC_DNS:/mnt/data/$new_file .
