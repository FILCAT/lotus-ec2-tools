#!/bin/bash
set -eux



export LOTUS_PATH=/mnt/data/lotus

/mnt/data/lotus-ec2-tools/lotus/lotus-shed --repo=$LOTUS_PATH stat-snapshot
