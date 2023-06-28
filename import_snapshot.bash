#!/bin/bash
set -eux
lotus_dir=/mnt/data/state-invariants-check/lotus
export LOTUS_PATH=/mnt/data/lotus
$lotus_dir/lotus daemon --halt-after-import --import-snapshot  /mnt/data/latest.zst
