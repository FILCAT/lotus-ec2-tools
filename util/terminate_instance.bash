#!/bin/bash
set -eux

aws ec2 terminate-instances --instance-ids "$1"
