#!/bin/bash
set -eux

#todo if no node given, provide help message and list nodes
node_name="$1"

INSTANCE_PUBLIC_DNS_FILE=$(mktemp)
INSTANCE_ID_FILE=$(mktemp)
./create_spot.bash $INSTANCE_PUBLIC_DNS_FILE $INSTANCE_ID_FILE

INSTANCE_PUBLIC_DNS="$(cat $INSTANCE_PUBLIC_DNS_FILE)"
INSTANCE_ID="$(cat $INSTANCE_ID_FILE)"

bash ./nodes/"$node_name"/run.bash "$INSTANCE_PUBLIC_DNS"

#don't terminate instance
#./terminate_instance.bash $INSTANCE_ID

rm -rf $INSTANCE_PUBLIC_DNS_FILE $INSTANCE_ID
