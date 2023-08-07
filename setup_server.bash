#!/bin/bash
set -eux

INSTANCE_PUBLIC_DNS="$1"

export SNAPSHOT_PATH=${SNAPSHOT_PATH:-}


for file in mount_disk.bash bootstrap.bash sshd_config.bash; do
  scp -i  ~/.ssh/aws.pem /mnt/lotus-ec2-tools/setup/"$file" ubuntu@$INSTANCE_PUBLIC_DNS:
done


ssh -i  ~/.ssh/aws.pem  ubuntu@$INSTANCE_PUBLIC_DNS bash mount_disk.bash
ssh -i  ~/.ssh/aws.pem  ubuntu@$INSTANCE_PUBLIC_DNS bash sshd_config.bash

if [[ -n $SNAPSHOT_PATH ]]; then
  scp -i  ~/.ssh/aws.pem $SNAPSHOT_PATH ubuntu@$INSTANCE_PUBLIC_DNS:/mnt/
fi

ssh -o SendEnv=LOTUS_GIT_BRANCH -i  ~/.ssh/aws.pem  ubuntu@$INSTANCE_PUBLIC_DNS bash bootstrap.bash
