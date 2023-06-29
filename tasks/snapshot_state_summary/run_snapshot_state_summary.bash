#!/bin/bash
set -eux

export LOTUS_PATH=/mnt/data/lotus

/mnt/data/lotus/lotus-shed --repo=$LOTUS_PATH stat-snapshot
