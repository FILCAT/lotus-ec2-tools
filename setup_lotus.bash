#!/bin/bash
set -eux
#todo install lotus build requirements
git clone git@github.com:filecoin-project/lotus.git 
cd lotus
make lotus lotus-shed
