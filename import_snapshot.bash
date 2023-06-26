#!/bin/bash
set -eux
./lotus/lotus daemon --halt-after-import --import-snapshot  latest.zst
