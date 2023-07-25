#!/bin/bash
set -eux
source /mnt/lotus-ec2-tools/.env

INSTANCE_PUBLIC_DNS="$1"
task_name="$2"

mkdir -p /mnt/lotus-ec2-tools/tasks/$task_name/data/

new_file="${task_name}-`date +"%Y-%m-%d-%H-%M-%S"`.out"
ssh -i  ~/.ssh/aws.pem  ubuntu@$INSTANCE_PUBLIC_DNS bash /mnt/lotus-ec2-tools/tasks/${task_name}/run_${task_name}.bash >  /mnt/lotus-ec2-tools/tasks/${task_name}/data/$new_file