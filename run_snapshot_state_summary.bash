#!/bin/bash
set -eux

export LOTUS_PATH=/mnt/data/lotus

sudo bash setup.bash
bash mount_disk.bash
bash setup_lotus.bash


bash download_snapshot.bash
bash import_snapshot.bash

./lotus/lotus-shed --repo=$LOTUS_PATH stat-snapshot
