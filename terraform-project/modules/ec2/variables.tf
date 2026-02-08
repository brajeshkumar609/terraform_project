#############################################
# Environment Name
#############################################

variable "environment" {
  description = "Environment name (dev/staging/prod)"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

#############################################
# Instance Type
#############################################

variable "instance_type" {
  description = "EC2 instance type"
  type        = string

  validation {
    condition     = can(regex("^t[2-3]\\..*", var.instance_type))
    error_message = "Only t2 or t3 instance types are allowed for safety."
  }
}

#############################################
# Optional Custom AMI
#############################################

variable "ami_id" {
  description = "Custom AMI ID (leave blank to use latest Amazon Linux)"
  type        = string
  default     = ""
}

#############################################
# Network Configuration
#############################################

variable "subnet_id" {
  description = "Subnet ID where EC2 will be launched"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "associate_public_ip" {
  description = "Assign public IP?"
  type        = bool
  default     = false
}

#############################################
# Key Pair
#############################################

variable "key_name" {
  description = "Existing AWS key pair name"
  type        = string
}

#############################################
# Tags
#############################################

variable "common_tags" {
  description = "Common tags to apply"
  type        = map(string)
}

#############################################
# Safety
#############################################

variable "prevent_destroy" {
  description = "Prevent accidental destroy"
  type        = bool
  default     = true
}
