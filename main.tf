



module "ec2_instances" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.0"

  name = var.project_name

  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  subnet_id     = data.aws_subnet.default.id
  
  count = var.instance_count

   tags = local.tags
}
module "bucket1" {
  source            = "./modules/aws-s3-bucket"
  bucket_name       = "iac-task2-bucket-1"
  tags              = local.tags 
  enable_versioning = var.enable_versioning
  attach_policy     = var.attach_policy
}

module "bucket2" {
  source            = "./modules/aws-s3-bucket"
  bucket_name       = "iac-task2-bucket-2"
  tags              = local.tags
  enable_versioning = false
  attach_policy     = false
}
