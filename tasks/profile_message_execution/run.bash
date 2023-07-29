#!/bin/bash
set -eux
source /mnt/lotus-ec2-tools/.env

INSTANCE_PUBLIC_DNS="$1"
task_name="$2"

mkdir -p /mnt/lotus-ec2-tools/tasks/$task_name/data/

ssh -i  ~/.ssh/aws.pem  ubuntu@$INSTANCE_PUBLIC_DNS bash /mnt/lotus-ec2-tools/tasks/${task_name}/run_task.bash


new_dir="${task_name}-`date +"%Y-%m-%d-%H-%M-%S"`"

new_dir_full=/mnt/lotus-ec2-tools/tasks/${task_name}/data/$new_dir
mkdir -p $new_dir_full

scp -i  ~/.ssh/aws.pem  ubuntu@$INSTANCE_PUBLIC_DNS:profile001.svg $new_dir_full/profile001.svg
scp -i  ~/.ssh/aws.pem  ubuntu@$INSTANCE_PUBLIC_DNS:profile002.svg $new_dir_full/profile002.svg
scp -i  ~/.ssh/aws.pem  ubuntu@$INSTANCE_PUBLIC_DNS:ApplyMessage.txt $new_dir_full/ApplyMessage.txt
scp -i  ~/.ssh/aws.pem  ubuntu@$INSTANCE_PUBLIC_DNS:RelativePercentages.txt $new_dir_full/RelativePercentages.txt

(
cd $new_dir_full
bash /mnt/lotus-ec2-tools/tasks/${task_name}/build_html.sh
)


ipfs_hash=$(ipfs add -q $new_dir_full/index.html)
slack_file=$(mktemp)
python3 /mnt/lotus-ec2-tools/slack/format_for_slack.py <(echo "A new Lotus Profiling Report on Message Execution is available: https://ipfs.io/ipfs/$ipfs_hash" ) >  $slack_file
curl -X POST -H 'Content-type: application/json' -d @$slack_file $SLACK_HOOK_URL
rm -rf $slack_file
