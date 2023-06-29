#!/bin/bash
set -eux

INSTANCE_PUBLIC_DNS="$1"

new_file="snapshot_state_summary-`date +"%Y-%m-%d-%H-%M-%S"`.out"
ssh -i  ~/.ssh/aws.pem  ubuntu@$INSTANCE_PUBLIC_DNS bash /mnt/data/state-invariants-check/tasks/snapshot_state_summary/run_snapshot_state_summary.bash >  $new_file
