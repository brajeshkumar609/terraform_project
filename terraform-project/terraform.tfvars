# --------------------------
# Environment
# --------------------------
environment = "prod"

# --------------------------
# Tags
# --------------------------
common_tags = {
  project = "terraform-prod"
  owner   = "brajesh"
}

# --------------------------
# Region (read by provider)
# --------------------------
aws_region = "us-east-1"

# --------------------------
# VPC & Subnets
# --------------------------
vpc_cidr = "10.0.0.0/16"

public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24",
]

private_subnet_cidrs = [
  "10.0.11.0/24",
  "10.0.12.0/24",
]

# Updated AZs for us-east-1
azs = ["us-east-1a", "us-east-1b"]

# --------------------------
# EC2
# --------------------------
# AMI will be resolved by data source (see code changes below)
instance_type = "t3.micro"

# Key pair must EXIST in us-east-1 (EC2 → Key Pairs)
key_name = "terraform"
# If your key pair in us-east-1 is named "AWS", then use:
# key_name = "AWS"
