#!/bin/bash
set -eux

sudo apt-get update
sudo apt install -y git

cd /mnt/
git clone https://github.com/FILCAT/lotus-ec2-tools.git

sudo bash /mnt/lotus-ec2-tools/setup/setup.bash
bash /mnt/lotus-ec2-tools/setup/setup_lotus.bash
bash /mnt/lotus-ec2-tools/setup/download_snapshot.bash
bash /mnt/lotus-ec2-tools/setup/import_snapshot.bash
