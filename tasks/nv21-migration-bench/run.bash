#!/bin/bash
set -eux
source /mnt/lotus-ec2-tools/.env

INSTANCE_PUBLIC_DNS="$1"
task_name="nv21-migration-bench"

mkdir -p /mnt/lotus-ec2-tools/tasks/$task_name/data/

new_file="${task_name}-`date +"%Y-%m-%d-%H-%M-%S"`.out"
ssh -i  ~/.ssh/aws.pem   -o SendEnv=EnvMigrationMaxWorkerCount ubuntu@$INSTANCE_PUBLIC_DNS bash /mnt/lotus-ec2-tools/tasks/${task_name}/run_task.bash $new_file
scp -i  ~/.ssh/aws.pem  ubuntu@$INSTANCE_PUBLIC_DNS:/mnt/$new_file /mnt/lotus-ec2-tools/tasks/${task_name}/data/$new_file


export INSTANCE_TYPE=${INSTANCE_TYPE:-i4i.2xlarge}
echo "Ec2 Instance Type - "$INSTANCE_TYPE >> /mnt/lotus-ec2-tools/tasks/${task_name}/data/$new_file

BRANCH=${LOTUS_GIT_BRANCH:-master}
echo "lotus branch - "$BRANCH >> /mnt/lotus-ec2-tools/tasks/${task_name}/data/$new_file

worker_count=${EnvMigrationMaxWorkerCount:-num-cpus}
echo "worker count - "$worker_count >> /mnt/lotus-ec2-tools/tasks/${task_name}/data/$new_file

#ping slack
slack_file=$(mktemp)
python3 /mnt/lotus-ec2-tools/slack/format_for_slack.py /mnt/lotus-ec2-tools/tasks/${task_name}/data/$new_file >  $slack_file
curl -X POST -H 'Content-type: application/json' -d @$slack_file $SLACK_HOOK_URL
rm -rf $slack_file
