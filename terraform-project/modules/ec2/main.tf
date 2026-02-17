# modules/ec2/main.tf

resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name

  # Performance & observability
  ebs_optimized = true # CKV_AWS_135
  monitoring    = true # CKV_AWS_136 (detailed CloudWatch monitoring)

  # Encrypt the root volume (CKV_AWS_8)
  root_block_device {
    volume_type = "gp3"
    volume_size = 20
    encrypted   = true
    # kms_key_id = var.kms_key_id     # optional: set if using a customer-managed CMK
  }

  # Attach an IAM instance profile (CKV2_AWS_41)
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = merge(var.common_tags, {
    Name = "${var.environment}-ec2"
  })

  lifecycle {
    create_before_destroy = true
  }
}

#######################################
# Minimal IAM role + instance profile #
#######################################

resource "aws_iam_role" "ec2_role" {
  name = "${var.environment}-ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { Service = "ec2.amazonaws.com" },
      Action    = "sts:AssumeRole"
    }]
  })
}

# Optional: SSM Session Manager access for the instance
resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.environment}-ec2-instance-profile"
  role = aws_iam_role.ec2_role.name
}

output "instance_id" { value = aws_instance.this.id }
output "public_ip" { value = aws_instance.this.public_ip }
output "private_ip" { value = aws_instance.this.private_ip }
