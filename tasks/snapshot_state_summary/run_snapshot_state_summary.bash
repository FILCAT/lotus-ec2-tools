#!/bin/bash
set -eux

export LOTUS_PATH=/mnt/data/lotus

/mnt/data/state-invariants-check/lotus/lotus-shed --repo=$LOTUS_PATH stat-snapshot
