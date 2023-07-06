#!/bin/bash
set -eux

INSTANCE_PUBLIC_DNS="$1"

new_file="snapshot_state_summary-`date +"%Y-%m-%d-%H-%M-%S"`.out"
ssh -i  ~/.ssh/aws.pem  ubuntu@$INSTANCE_PUBLIC_DNS bash /mnt/data/state-invariants-check/tasks/snapshot_state_summary/run_snapshot_state_summary.bash >  $new_file



cd /mnt/data/state-invariants-check/tasks/snapshot_state_summary
python3 build_html.py
ipfs_hash=$(ipfs add -q index.html)

slack_file=$(mktemp)
echo "https://ipfs.io/ipfs/$ipfs_hash" >  $slack_file
python3 /mnt/data/state-invariants-check/tasks/state_invariants_check/format_for_slack.py $new_file >  $slack_file
curl -X POST -H 'Content-type: application/json' -d @$slack_file $SLACK_HOOK_URL
rm -rf $slack_file
