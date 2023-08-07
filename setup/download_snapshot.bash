#!/bin/bash
set -eux

#file may already exist if it was uploaded to the server through scp via the SNAPSHOT_PATH env variable
if [[ ! -e /mnt/latest.zst ]]; then
	    aria2c -x5 https://snapshots.mainnet.filops.net/minimal/latest.zst -o latest.zst --dir=/mnt/
fi

#aria2c -x5 https://snapshots.calibrationnet.filops.net/minimal/latest.zst -o latest.zst --dir=/mnt/
