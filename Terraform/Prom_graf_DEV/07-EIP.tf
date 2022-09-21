resource "aws_eip" "elastic_IP" {
  vpc = true

  tags = {
      Name = "Prom Graf Elastic IP"
  }
}