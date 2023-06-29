#!/bin/bash
set -eux

# Set the necessary variables
export AWS_REGION='us-west-1' # Change this to the AWS Region you want
export KEY_NAME='mikers-2' # Change this to your EC2 Key Pair name
export INSTANCE_TYPE='t3.medium'
export SECURITY_GROUP='sg-0cc4bf7380c6a7dbe'
export AMI='ami-0f8e81a3da6e2510a'


# Request On-Demand Instance
INSTANCE_ID=$(aws ec2 run-instances \
    --region "$AWS_REGION" \
    --image-id "$AMI" \
    --count 1 \
    --instance-type "$INSTANCE_TYPE" \
    --key-name "$KEY_NAME" \
    --security-group-ids "$SECURITY_GROUP" \
    --query 'Instances[*].InstanceId' --output text)

# Wait until the instance is running
aws ec2 wait instance-running --region "$AWS_REGION" --instance-ids "$INSTANCE_ID"

# Get the Public DNS of the newly created Spot Instance
INSTANCE_PUBLIC_DNS=$(aws ec2 describe-instances --region "$AWS_REGION" --instance-ids "$INSTANCE_ID" --query 'Reservations[].Instances[].PublicDnsName' --output text)

#make sure instance and ssh is up
sleep 60

# SSH into the instance and run task
./setup_server.bash $INSTANCE_PUBLIC_DNS

