#!/bin/bash
set -eux
lotus_dir=/mnt/lotus
export LOTUS_PATH=/mnt/lotus-data
$lotus_dir/lotus daemon --halt-after-import --import-snapshot  /mnt/latest.zst
