#!/bin/bash

# Replace this with your target VPC ID
VPC_ID="vpc-09d68d082bdc0b7c9"

echo "Cleaning up resources in VPC: $VPC_ID"

# 1. Delete NAT Gateways
echo "Deleting NAT Gateways..."
NAT_IDS=$(aws ec2 describe-nat-gateways --filter Name=vpc-id,Values=$VPC_ID --query 'NatGateways[*].NatGatewayId' --output text)
for nat_id in $NAT_IDS; do
  echo "Deleting NAT Gateway: $nat_id"
  aws ec2 delete-nat-gateway --nat-gateway-id $nat_id
done

# Wait for NAT gateways to delete (optional but recommended)
echo "Waiting 60 seconds for NAT Gateways to be deleted..."
sleep 60

# 2. Detach and delete Internet Gateways
echo "Detaching and deleting Internet Gateways..."
IGW_IDS=$(aws ec2 describe-internet-gateways --filters Name=attachment.vpc-id,Values=$VPC_ID --query 'InternetGateways[*].InternetGatewayId' --output text)
for igw_id in $IGW_IDS; do
  echo "Detaching Internet Gateway $igw_id from VPC $VPC_ID"
  aws ec2 detach-internet-gateway --internet-gateway-id $igw_id --vpc-id $VPC_ID
  echo "Deleting Internet Gateway $igw_id"
  aws ec2 delete-internet-gateway --internet-gateway-id $igw_id
done

# 3. Delete subnets
echo "Deleting Subnets..."
SUBNET_IDS=$(aws ec2 describe-subnets --filters Name=vpc-id,Values=$VPC_ID --query 'Subnets[*].SubnetId' --output text)
for subnet_id in $SUBNET_IDS; do
  echo "Deleting Subnet: $subnet_id"
  aws ec2 delete-subnet --subnet-id $subnet_id
done

# 4. Delete non-main route tables
echo "Deleting non-main Route Tables..."
RTB_IDS=$(aws ec2 describe-route-tables --filters Name=vpc-id,Values=$VPC_ID --query 'RouteTables[?Associations[?Main==`false`]].RouteTableId' --output text)
for rtb_id in $RTB_IDS; do
  echo "Deleting Route Table: $rtb_id"
  aws ec2 delete-route-table --route-table-id $rtb_id
done

# 5. Delete security groups except default
echo "Deleting Security Groups (except default)..."
SGS=$(aws ec2 describe-security-groups --filters Name=vpc-id,Values=$VPC_ID --query 'SecurityGroups[?GroupName!=`default`].GroupId' --output text)
for sg_id in $SGS; do
  echo "Deleting Security Group: $sg_id"
  aws ec2 delete-security-group --group-id $sg_id
done

# 6. Delete Network Interfaces (optional, usually deleted with subnets)
echo "Deleting Network Interfaces..."
ENI_IDS=$(aws ec2 describe-network-interfaces --filters Name=vpc-id,Values=$VPC_ID --query 'NetworkInterfaces[*].NetworkInterfaceId' --output text)
for eni_id in $ENI_IDS; do
  echo "Deleting Network Interface: $eni_id"
  aws ec2 delete-network-interface --network-interface-id $eni_id
done

# Finally, delete the VPC
echo "Deleting VPC $VPC_ID"
aws ec2 delete-vpc --vpc-id $VPC_ID

echo "Cleanup complete."
