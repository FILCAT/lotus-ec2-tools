#!/bin/bash
set -eux
source /mnt/lotus-ec2-tools/.env

INSTANCE_PUBLIC_DNS="$1"
task_name="TASKNAMESENTINEL"

mkdir -p /mnt/lotus-ec2-tools/tasks/$task_name/data/

new_file="${task_name}-`date +"%Y-%m-%d-%H-%M-%S"`.out"
ssh -i  ~/.ssh/aws.pem  ubuntu@$INSTANCE_PUBLIC_DNS bash /mnt/lotus-ec2-tools/tasks/${task_name}/run_task.bash >  /mnt/lotus-ec2-tools/tasks/${task_name}/data/$new_file

#ping slack
slack_file=$(mktemp)
python3 /mnt/lotus-ec2-tools/slack/format_for_slack.py /mnt/lotus-ec2-tools/tasks/${task_name}/data/$new_file >  $slack_file
curl -X POST -H 'Content-type: application/json' -d @$slack_file $SLACK_HOOK_URL
rm -rf $slack_file
