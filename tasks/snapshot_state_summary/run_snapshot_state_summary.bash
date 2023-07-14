#!/bin/bash
set -eux



export LOTUS_PATH=/mnt/lotus-data

/mnt/lotus-ec2-tools/lotus/lotus-shed --repo=$LOTUS_PATH stat-snapshot
