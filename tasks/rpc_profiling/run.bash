#!/bin/bash
set -eux
source /mnt/lotus-ec2-tools/.env

INSTANCE_PUBLIC_DNS="$1"
task_name="rpc_profiling"

mkdir -p /mnt/lotus-ec2-tools/tasks/$task_name/data/

new_file=/mnt/lotus-ec2-tools/tasks/${task_name}/data/"${task_name}-`date +"%Y-%m-%d-%H-%M-%S"`.txt"
ssh -i  ~/.ssh/aws.pem  ubuntu@$INSTANCE_PUBLIC_DNS bash /mnt/lotus-ec2-tools/tasks/${task_name}/run_task.bash >  $new_file



ipfs_hash=$(ipfs add -q $new_file)
slack_file=$(mktemp)
python3 /mnt/lotus-ec2-tools/slack/format_for_slack.py <(echo "A new Lotus Profiling Report on RPC Response times is available: https://ipfs.io/ipfs/$ipfs_hash" ) >  $slack_file
curl -X POST -H 'Content-type: application/json' -d @$slack_file $SLACK_HOOK_URL
rm -rf $slack_file
