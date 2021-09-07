# Check if that respective Instance Type is supported in that Specific Region in list of availability Zone
# Get the List of Availability Zone in a Particular region where that respective Instance Type is supported

data "aws_ec2_instance_type_offerings" "my_ins_type2" {
  for_each = toset([ "us-east-1a", "us-east-1b", "us-east-1e" ])
    filter {
      name = "instance-type"
      values = [ "t3.micro" ]
    }

    filter {
      name = "location"
      #values = ["us-east-1a"]
      values = [each.key]
    }
    location_type = "availability-zone"
}

# Output-1
# Important Note: Once for_each is set, its attributes must be accessed on specific instances
output "out_v2_1" {
  #value = data.aws_ec2_instance_type_offering.my_ins_type2.instance_types
  value = [ for t in data.aws_ec2_instance_type_offerings.my_ins_type2: t.instance_types ]
}