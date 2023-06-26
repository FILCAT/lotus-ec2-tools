#!/bin/bash
set -eux
./lotus/lotus daemon --halt-after-import --import-snapshot  /mnt/data/latest.zst
