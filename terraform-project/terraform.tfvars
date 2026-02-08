# ---- Environment ----
environment = "prod"

# ---- Tags ----
common_tags = {
  project = "terraform-prod"
  owner   = "brajesh"
}

# ---- VPC ----
vpc_cidr = "10.0.0.0/16"

public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24",
]

private_subnet_cidrs = [
  "10.0.11.0/24",
  "10.0.12.0/24",
]

# Adjust AZs to your region & account
azs = ["ap-south-1a", "ap-south-1b"]

# ---- EC2 ----
# Make sure this AMI exists in your chosen region (ap-south-1 example below)
ami_id        = "ami-0f5ee92e2d63afc18"
instance_type = "t2.micro"

# This key pair must already exist in the same region
key_name = "terraform"
