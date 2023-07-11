#!/bin/bash
set -eux

dir=/mnt/data/lotus-ec2-tools/nodes/lotus

sudo cp $dir/lotus.service /etc/systemd/system/

sudo systemctl daemon-reload
sudo systemctl enable lotus.service
sudo systemctl start lotus.service

