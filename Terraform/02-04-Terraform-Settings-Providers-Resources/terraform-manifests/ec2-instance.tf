# Resource: EC2 Instance
resource "aws_instance" "myec2vm" {
  ami = "ami-0c2b8ca1dad447f8a"
  instance_type = "t3.micro"
  user_data = file("${path.module}/apache.sh")

  tags = {
      "Name" = "EC2 Demo"
  }
}