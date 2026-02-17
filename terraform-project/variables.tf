##############################################
# Environment & Tags
##############################################
variable "environment" {
  description = "Environment name (dev/qa/stage/prod)"
  type        = string
  validation {
    condition     = contains(["dev", "qa", "stage", "prod"], var.environment)
    error_message = "environment must be one of: dev, qa, stage, prod."
  }
}

variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
}

##############################################
# VPC inputs
##############################################
variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDRs for public subnets"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDRs for private subnets"
}

variable "azs" {
  type        = list(string)
  description = "Availability zones for subnets (must match subnet list lengths)"
}

##############################################
# EC2 inputs
##############################################
variable "ami_id" {
  type        = string
  description = "AMI ID for EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  validation {
    condition     = can(regex("^t2|t3|t4g|c5|m5|r5", var.instance_type))
    error_message = "Use a valid instance family (t2, t3, t4g, c5, m5, r5, etc.)."
  }
}

variable "key_name" {
  type        = string
  description = "Name of an existing EC2 key pair in the selected region"
}

variable "aws_region" {
  type        = string
  description = "AWS region to deploy into"
}

