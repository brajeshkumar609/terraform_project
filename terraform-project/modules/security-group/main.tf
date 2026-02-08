resource "aws_security_group" "this" {
  name        = "${var.environment}-sg"
  description = "Security group for EC2"
  vpc_id      = var.vpc_id

  # Allow SSH from anywhere (for learning). Tighten this in real projects.
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, { Name = "${var.environment}-sg" })
}
