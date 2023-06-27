#!/bin/bash
set -eux
export LOTUS_PATH=/mnt/data/lotus
./lotus/lotus daemon --halt-after-import --import-snapshot  /mnt/data/latest.zst
