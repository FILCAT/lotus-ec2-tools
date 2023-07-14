#!/bin/bash
set -eux

sudo mkdir -p /mnt/logs/lotus/

dir=/mnt/lotus-ec2-tools/nodes/lotus

sudo cp $dir/lotus.service /etc/systemd/system/

sudo systemctl daemon-reload
sudo systemctl enable lotus.service
sudo systemctl start lotus.service

