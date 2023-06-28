#!/bin/bash
set -eux

aws ec2 stop-instances --instance-ids "$1"
