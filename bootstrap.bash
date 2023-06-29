#!/bin/bash
set -eux

sudo apt-get update
sudo apt install -y git

bash mount_disk.bash

cd /mnt/data/
git clone https://github.com/snissn/state-invariants-check.git

sudo bash /mnt/data/state-invariants-check/setup.bash
bash /mnt/data/state-invariants-check/setup_lotus.bash
bash /mnt/data/state-invariants-check/download_snapshot.bash
bash /mnt/data/state-invariants-check/import_snapshot.bash
