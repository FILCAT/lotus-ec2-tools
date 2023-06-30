#!/bin/bash
set -eux

# Set the necessary variables
export AWS_REGION='us-west-1' # Change this to the AWS Region you want
export KEY_NAME='mikers-2' # Change this to your EC2 Key Pair name
export INSTANCE_TYPE='i4i.2xlarge' # Change this to your preferred instance type
export SECURITY_GROUP='sg-0cc4bf7380c6a7dbe'
export AMI='ami-0f8e81a3da6e2510a'

INSTANCE_PUBLIC_DNS_FILE=${1:-/dev/stdout}
INSTANCE_ID_FILE=${2:-/dev/stdout}


# Request Spot Instance. The `--query` option extracts the `SpotInstanceRequestId` from the response
SPOT_INSTANCE_ID=$(aws ec2 request-spot-instances \
    --region "$AWS_REGION" \
    --spot-price "0.85" \
    --instance-count 1 \
    --type "one-time" \
    --launch-specification "{
        \"ImageId\":\"$AMI\",
        \"InstanceType\":\"$INSTANCE_TYPE\",
        \"KeyName\":\"$KEY_NAME\",
        \"SecurityGroupIds\":[\"$SECURITY_GROUP\"]
    }" --query 'SpotInstanceRequests[*].SpotInstanceRequestId' --output text)

# Wait until the Spot Instance is fulfilled
aws ec2 wait spot-instance-request-fulfilled --region "$AWS_REGION" --spot-instance-request-ids "$SPOT_INSTANCE_ID"

# Get the Instance ID of the newly created Spot Instance
INSTANCE_ID=$(aws ec2 describe-spot-instance-requests --region "$AWS_REGION" --spot-instance-request-ids "$SPOT_INSTANCE_ID" --query 'SpotInstanceRequests[*].InstanceId' --output text)

# Wait until the instance is running
aws ec2 wait instance-running --region "$AWS_REGION" --instance-ids "$INSTANCE_ID"

# Get the Public DNS of the newly created Spot Instance
INSTANCE_PUBLIC_DNS=$(aws ec2 describe-instances --region "$AWS_REGION" --instance-ids "$INSTANCE_ID" --query 'Reservations[].Instances[].PublicDnsName' --output text)

#make sure instance and ssh is up
sleep 60

# SSH into the instance and run task
./setup_server.bash $INSTANCE_PUBLIC_DNS

echo $INSTANCE_PUBLIC_DNS > $INSTANCE_PUBLIC_DNS_FILE
echo $INSTANCE_ID > $INSTANCE_ID_FILE
