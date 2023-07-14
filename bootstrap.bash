#!/bin/bash
set -eux

sudo apt-get update
sudo apt install -y git

bash mount_disk.bash

cd /mnt/
git clone https://github.com/FILCAT/lotus-ec2-tools.git

sudo bash /mnt/lotus-ec2-tools/setup.bash
bash /mnt/lotus-ec2-tools/setup_lotus.bash
bash /mnt/lotus-ec2-tools/download_snapshot.bash
bash /mnt/lotus-ec2-tools/import_snapshot.bash
