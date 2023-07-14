#!/bin/bash
set -eux
rm -f /mnt/latest.zst

aria2c -x5 https://snapshots.mainnet.filops.net/minimal/latest.zst -o latest.zst --dir=/mnt/
#aria2c -x5 https://snapshots.calibrationnet.filops.net/minimal/latest.zst -o latest.zst --dir=/mnt/
