#!/bin/bash
set -eux

#todo if no task given, provide help message and list tasks
task_name="$1"

INSTANCE_PUBLIC_DNS_FILE=$(mktemp)
INSTANCE_ID_FILE=$(mktemp)
./create_spot.bash $INSTANCE_PUBLIC_DNS_FILE $INSTANCE_ID_FILE

INSTANCE_PUBLIC_DNS="$(cat $INSTANCE_PUBLIC_DNS_FILE)"
INSTANCE_ID="$(cat $INSTANCE_ID_FILE)"

bash ./tasks/"$task_name"/run.bash "$INSTANCE_PUBLIC_DNS"

#terminate instance
./ec2/terminate_instance.bash $INSTANCE_ID

rm -rf $INSTANCE_PUBLIC_DNS_FILE $INSTANCE_ID
