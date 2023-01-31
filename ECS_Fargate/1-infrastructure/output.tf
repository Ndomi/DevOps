output "vpc_id" {
  value = aws_vpc.production_vpc.id
}

output "vpc_cidr_block" {
  value = aws_vpc.production_vpc.cidr_block
}

output "public_subnet_1_id" {
  value = aws_subnet.production_public_subnet_one.id
}

output "public_subnet_2_id" {
  value = aws_subnet.production_public_subnet_two.id
}

output "public_subnet_3_id" {
  value = aws_subnet.production_public_subnet_three.id
}

output "private_subnet_1_id" {
  value = aws_subnet.production_private_subnet_one.id
}

output "private_subnet_2_id" {
  value = aws_subnet.production_private_subnet_two.id
}

output "private_subnet_3_id" {
  value = aws_subnet.production_private_subnet_three.id
}

output "private_subnets" {
  value = tolist([aws_subnet.production_private_subnet_one.id, aws_subnet.production_private_subnet_two.id, aws_subnet.production_private_subnet_three.id])
}

output "public_subnets" {
  value = tolist([aws_subnet.production_public_subnet_one.id, aws_subnet.production_public_subnet_two.id, aws_subnet.production_public_subnet_three.id])
}

