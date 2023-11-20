#!/bin/bash
set -eux
#run this as root

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt install -y hwloc mesa-opencl-icd ocl-icd-opencl-dev gcc git bzr jq pkg-config curl clang build-essential hwloc libhwloc-dev wget aria2 awscli graphviz pv
apt upgrade -y

curl https://sh.rustup.rs -sSf | sh -s -- -y

GO_VERSION_MIN=$(curl https://raw.githubusercontent.com/filecoin-project/lotus/master/GO_VERSION_MIN)
wget -c https://golang.org/dl/go$GO_VERSION_MIN.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local
