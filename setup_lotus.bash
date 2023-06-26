#!/bin/bash
set -eux
git clone https://github.com/filecoin-project/lotus.git
cd lotus
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc && source ~/.bashrc
make lotus lotus-shed
