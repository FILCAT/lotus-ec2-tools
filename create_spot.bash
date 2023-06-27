#!/bin/bash
set -eux

#!/bin/bash

# Set the necessary variables
export AWS_REGION='us-west-1' # Change this to the AWS Region you want

#TODO use diff keypair
export KEY_NAME='mikers-2' # Change this to your EC2 Key Pair name

export INSTANCE_TYPE='t2.micro' # Change this to your preferred instance type
export SECURITY_GROUP='sg-0cc4bf7380c6a7dbe'
export AMI='ami-0f8e81a3da6e2510a'

# Request Spot Instance. The `--query` option extracts the `SpotInstanceRequestId` from the response
SPOT_INSTANCE_ID=$(aws ec2 request-spot-instances \
    --region "$AWS_REGION" \
    --spot-price "0.05" \
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

# Get the Instance ID and Public DNS of the newly created Spot Instance
INSTANCE_DETAILS=$(aws ec2 describe-spot-instance-requests --region "$AWS_REGION" --spot-instance-request-ids "$SPOT_INSTANCE_ID" --query 'SpotInstanceRequests[*].{InstanceId:InstanceId,PublicDnsName:LaunchedAvailabilityZone}' --output text)
INSTANCE_ID=$(echo $INSTANCE_DETAILS | awk '{print $1}')
INSTANCE_PUBLIC_DNS=$(echo $INSTANCE_DETAILS | awk '{print $2}')

# Wait until the instance is running
aws ec2 wait instance-running --region "$AWS_REGION" --instance-ids "$INSTANCE_ID"

# SSH into the instance and run 'echo hello world'
ssh -i /path/to/your/key.pem ec2-user@$INSTANCE_PUBLIC_DNS 'echo hello world'


