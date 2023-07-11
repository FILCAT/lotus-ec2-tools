#!/bin/bash
set -eux

sudo apt-get update
sudo apt install -y git

bash mount_disk.bash

cd /mnt/data/
git clone https://github.com/snissn/lotus-ec2-tools.git

sudo bash /mnt/data/lotus-ec2-tools/setup.bash
bash /mnt/data/lotus-ec2-tools/setup_lotus.bash
bash /mnt/data/lotus-ec2-tools/download_snapshot.bash
bash /mnt/data/lotus-ec2-tools/import_snapshot.bash
