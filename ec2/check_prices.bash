#!/bin/bash
set -eu
# Get list of running instance IDs
instance_ids=$(aws ec2 describe-instances --query 'Reservations[*].Instances[?State.Name==`running`].InstanceId' --output text)

echo "Instance ID | Instance Type | Public IP Address | Availability Zone | Current Spot Price"

# Loop over each instance ID
for INSTANCE_ID in $instance_ids
do
  # Get instance type, availability zone, and public IP address
  instance_info=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[].Instances[].[InstanceType,PublicIpAddress,Placement.AvailabilityZone]' --output text)
  instance_type=$(echo $instance_info | awk '{print $1}')
  public_ip=$(echo $instance_info | awk '{print $2}')
  availability_zone=$(echo $instance_info | awk '{print $3}')

  # Get the current spot price for your instance type in your availability zone
  current_price=$(aws ec2 describe-spot-price-history --instance-types $instance_type --availability-zone $availability_zone --product-descriptions "Linux/UNIX" --query 'SpotPriceHistory[0].SpotPrice' --output text)

  echo "$INSTANCE_ID | $instance_type | $public_ip | $availability_zone | $current_price"
done
