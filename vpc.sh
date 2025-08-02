#!/bin/bash

# List of VPC IDs to delete
vpcs=(
  "vpc-09d68d082bdc0b7c9"
  "vpc-02747f181aec57311"
  "vpc-091763c67e7ca3d9b"
  "vpc-0da2b3e4ad758b9b3"
  "vpc-010199b093576d072"
)

for vpc_id in "${vpcs[@]}"; do
  echo "Starting deletion of VPC: $vpc_id"

  # 1. Delete Subnets in the VPC
  echo "Deleting subnets in VPC $vpc_id..."
  subnet_ids=$(aws ec2 describe-subnets --filters "Name=vpc-id,Values=$vpc_id" --query "Subnets[].SubnetId" --output text)
  for subnet_id in $subnet_ids; do
    echo "Deleting subnet $subnet_id"
    aws ec2 delete-subnet --subnet-id "$subnet_id"
  done

  # 2. Detach and delete Internet Gateways
  echo "Detaching and deleting internet gateways in VPC $vpc_id..."
  igw_ids=$(aws ec2 describe-internet-gateways --filters "Name=attachment.vpc-id,Values=$vpc_id" --query "InternetGateways[].InternetGatewayId" --output text)
  for igw_id in $igw_ids; do
    echo "Detaching IGW $igw_id"
    aws ec2 detach-internet-gateway --internet-gateway-id "$igw_id" --vpc-id "$vpc_id"
    echo "Deleting IGW $igw_id"
    aws ec2 delete-internet-gateway --internet-gateway-id "$igw_id"
  done

  # 3. Delete Route Table Associations (except main)
  echo "Deleting non-main route tables in VPC $vpc_id..."
  route_table_ids=$(aws ec2 describe-route-tables --filters "Name=vpc-id,Values=$vpc_id" --query "RouteTables[?Associations[?Main==\`false\`]].RouteTableId" --output text)
  for rtb_id in $route_table_ids; do
    echo "Deleting route table $rtb_id"
    aws ec2 delete-route-table --route-table-id "$rtb_id"
  done

  # 4. Delete Network ACLs (except default)
  echo "Deleting non-default network ACLs in VPC $vpc_id..."
  acl_ids=$(aws ec2 describe-network-acls --filters "Name=vpc-id,Values=$vpc_id" --query "NetworkAcls[?IsDefault==\`false\`].NetworkAclId" --output text)
  for acl_id in $acl_ids; do
    echo "Deleting network ACL $acl_id"
    aws ec2 delete-network-acl --network-acl-id "$acl_id"
  done

  # 5. Delete Security Groups (except default)
  echo "Deleting non-default security groups in VPC $vpc_id..."
  sg_ids=$(aws ec2 describe-security-groups --filters "Name=vpc-id,Values=$vpc_id" --query "SecurityGroups[?GroupName!='default'].GroupId" --output text)
  for sg_id in $sg_ids; do
    echo "Deleting security group $sg_id"
    aws ec2 delete-security-group --group-id "$sg_id"
  done

  # 6. Finally delete the VPC
  echo "Deleting VPC $vpc_id..."
  aws ec2 delete-vpc --vpc-id "$vpc_id"

  echo "Deletion process completed for VPC $vpc_id"
  echo "---------------------------------------"
done
