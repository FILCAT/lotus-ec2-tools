#!/bin/bash
set -eux

# Set BRANCH to the value of LOTUS_NETWORK, or to 'mainnet' if LOTUS_NETWORK is not set
LOTUS_NETWORK=${LOTUS_NETWORK:-mainnet}

# Check if the file already exists, which may be the case if it was uploaded to the server
# via scp through the SNAPSHOT_PATH environment variable
if [[ ! -e /mnt/latest.zst ]]; then

    # Determine the appropriate action based on the value of LOTUS_NETWORK
    if [ "$LOTUS_NETWORK" == "mainnet" ]; then
        # Download the latest mainnet snapshot using aria2
        aria2c -x5 https://snapshots.mainnet.filops.net/minimal/latest.zst -o latest.zst --dir=/mnt/
    elif [ "$LOTUS_NETWORK" == "calibnet" ]; then
        # Download the latest calibration net snapshot using aria2
        aria2c -x5 https://snapshots.calibrationnet.filops.net/minimal/latest.zst -o latest.zst --dir=/mnt/
    else
        # Print an error message and exit if LOTUS_NETWORK has an unrecognized value
        echo "Unrecognized LOTUS_NETWORK value: $LOTUS_NETWORK"
        exit 1
    fi

fi
