#!/bin/bash
set -eux

INSTANCE_PUBLIC_DNS="$1"

for file in mount_disk.bash bootstrap.bash; do
  scp -i  ~/.ssh/aws.pem /mnt/lotus-ec2-tools/"$file" ubuntu@$INSTANCE_PUBLIC_DNS:
done

ssh -i  ~/.ssh/aws.pem  ubuntu@$INSTANCE_PUBLIC_DNS bash bootstrap.bash
