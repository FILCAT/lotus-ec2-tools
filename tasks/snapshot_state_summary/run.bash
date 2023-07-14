#!/bin/bash
set -eux

INSTANCE_PUBLIC_DNS="$1"
source /mnt/lotus-ec2-tools/.env

new_file="snapshot_state_summary-`date +"%Y-%m-%d-%H-%M-%S"`.out"
ssh -i  ~/.ssh/aws.pem  ubuntu@$INSTANCE_PUBLIC_DNS bash /mnt/lotus-ec2-tools/tasks/snapshot_state_summary/run_snapshot_state_summary.bash >  /mnt/lotus-ec2-tools/tasks/snapshot_state_summary/data/$new_file



cd /mnt/lotus-ec2-tools/tasks/snapshot_state_summary
python3 build_html.py
ipfs_hash=$(ipfs add -q index.html)

slack_file=$(mktemp)
echo "A new Filecoin State Usage Summary is available: https://ipfs.io/ipfs/$ipfs_hash" >  $slack_file
python3 /mnt/lotus-ec2-tools/slack/format_for_slack.py /mnt/lotus-ec2-tools/tasks/snapshot_state_summary/data/$new_file >  $slack_file
curl -X POST -H 'Content-type: application/json' -d @$slack_file $SLACK_HOOK_URL_snapshot_state_summary
rm -rf $slack_file
