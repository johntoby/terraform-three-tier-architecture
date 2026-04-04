# terraform {
#   backend "s3" {
#     bucket = "threetier-terraform-state-bucket"
#     key    = "terraform.tfstate"
#     region = "us-east-1"
#     encrypt = true
#     use_lockfile = true
#   }
# }


# # Create the s3 bucket for remote statefile storage

# resource "aws_s3_bucket" "threetier-terraform-state-bucket" {
#   bucket = "threetier-terraform-state-bucket"

#   lifecycle {
#     prevent_destroy = true
#   }

#   tags = {
#     Name        = "threetier-terraform-state-bucket"
#     Environment = "Prod"
#   }
# }


# # enable s3 bucket versioning 

# resource "aws_s3_bucket_versioning" "terraform_state" {
#   bucket = aws_s3_bucket.threetier-terraform-state-bucket.id

#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# # enable server side s3 bucket encryption 
# resource "aws_kms_key" "ThreeTier_Key" {
#   description             = "This key is used to encrypt bucket objects"
#   deletion_window_in_days = 10
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
#   bucket = aws_s3_bucket.threetier-terraform-state-bucket.id

#   rule {
#     apply_server_side_encryption_by_default {
#       kms_master_key_id = aws_kms_key.ThreeTier_Key.id
#       sse_algorithm     = "aws:kms"
#     }
#   }
# }

# # 
# resource "aws_s3_bucket_public_access_block" "terraform_state" {
#   bucket = aws_s3_bucket.threetier-terraform-state-bucket.id

#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }



