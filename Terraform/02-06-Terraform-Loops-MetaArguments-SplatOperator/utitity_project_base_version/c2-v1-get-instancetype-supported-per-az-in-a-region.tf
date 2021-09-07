# Datasource
data "aws_ec2_instance_type_offerings" "my_inst_type" {
    filter {
      name = "instance-type"
      values = [ "t3.micro" ]
    }

    filter {
      name = "location"
      #values = ["us-east-1a"]
      values = ["us-east-1e"]
    }
    location_type = "availability-zone"
}

# Output
output "output_v1_1" {
  value = data.aws_ec2_instance_type_offerings.my_inst_type.instance_types
}

# Create a Map with Key as Availability Zone and value as Instance Type support
output "output_v2_2" {
  for az, details in data.aws_ec2_in
}