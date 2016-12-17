resource "aws_security_group" "bastion" {
  name        = "Bastion host"
  description = "Bastion host"
  vpc_id      = "${var.vpc}"

  # SSH access from the world
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags {
    Name = "bastion",
    Provider = "terraform"
  }
}
