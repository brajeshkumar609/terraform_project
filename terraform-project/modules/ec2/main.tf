#############################################
# Fetch Latest Amazon Linux 2 AMI
# This avoids hardcoding AMI IDs
#############################################

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

#############################################
# EC2 Instance Resource
#############################################

resource "aws_instance" "this" {

  ami           = var.ami_id != "" ? var.ami_id : data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  vpc_security_group_ids = var.security_group_ids

  key_name = var.key_name

  associate_public_ip_address = var.associate_public_ip

  monitoring = true   # Enable detailed monitoring (production best practice)

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-ec2"
    }
  )

  #############################################
  # Lifecycle Rules (Prevents Accidental Destroy)
  #############################################
  lifecycle {
  prevent_destroy = true
}

}
