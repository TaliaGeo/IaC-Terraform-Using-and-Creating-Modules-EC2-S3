variable "aws_region" {
  description = "The AWS region to launch resources in"
  type        = string
}

variable "instance_count" {
  description = "Number of EC2 instances"
  type        = number
  default     = 2
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}


variable "owner" {
  description = "Owner tag for EC2 instances"
  type        = string
}


variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
 
}
variable "ManagedBy" {
  description = "Who manages the resources"
  type        = string
  
}

variable "tags" {
  type = map(string)
  default = {}
}

variable "enable_versioning" {
  type = bool
}

variable "attach_policy" {
  type = bool 
}

