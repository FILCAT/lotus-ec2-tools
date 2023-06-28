#!/bin/bash
set -eux

INSTANCE_PUBLIC_DNS="$1"

for file in mount_disk.bash bootstrap.bash; do
  scp -i  ~/Downloads/mikers-2.pem "$file" ubuntu@$INSTANCE_PUBLIC_DNS:
done

ssh -i  ~/Downloads/mikers-2.pem  ubuntu@$INSTANCE_PUBLIC_DNS bash bootstrap.bash
