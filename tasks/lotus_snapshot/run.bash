#!/bin/bash
set -eux
source /mnt/lotus-ec2-tools/.env

INSTANCE_PUBLIC_DNS="$1"
task_name="$2"

mkdir -p /mnt/lotus-ec2-tools/tasks/$task_name/data/

ssh -i  ~/.ssh/aws.pem  ubuntu@$INSTANCE_PUBLIC_DNS bash /mnt/lotus-ec2-tools/tasks/${task_name}/run_task.bash

