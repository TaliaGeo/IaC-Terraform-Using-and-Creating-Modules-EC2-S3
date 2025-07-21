
output "region" {
  value = var.aws_region
}

output "public_ips" {
  description = "Public IPs of the EC2 instances"
  value       = module.ec2_instances[*].public_ip
}
output "bucket1_name" {
  value = module.bucket1.bucket_name
}
output "bucket2name" {
  value = module.bucket2.bucket_name
}

output "bucket2_arn" {
  value = module.bucket2.bucket_arn
}
output "bucket1arn" {
  value = module.bucket1.bucket_arn
}
