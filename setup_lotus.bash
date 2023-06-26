#!/bin/bash
set -eux
git clone https://github.com/filecoin-project/lotus.git
cd lotus
make lotus lotus-shed
