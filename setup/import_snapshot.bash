#!/bin/bash
set -eux
lotus_dir=/mnt/lotus
export LOTUS_PATH=/mnt/lotus-data
#try new format then old format if not
$lotus_dir/lotus daemon --halt-after-import --remove-existing-chain --import-snapshot  /mnt/latest.zst || $lotus_dir/lotus daemon --halt-after-import --import-snapshot  /mnt/latest.zst
