#!/bin/bash
set -eux



export LOTUS_PATH=/mnt/lotus-data

/mnt/lotus/lotus-shed --repo=$LOTUS_PATH stat-snapshot
