# Optional: if you prefer to always use the latest Amazon Linux 2 for the region,
# you can use a data source and ignore the ami_id variable. For now, we use ami_id from root.

resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name

  tags = merge(var.common_tags, {
    Name = "${var.environment}-ec2"
  })

  lifecycle {
    create_before_destroy = true
  }
}

output "instance_id" {
  value = aws_instance.this.id
}

output "public_ip" {
  value = aws_instance.this.public_ip
}

output "private_ip" {
  value = aws_instance.this.private_ip
}
