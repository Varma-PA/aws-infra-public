resource "aws_s3_bucket" "my_s3_bucket" {
  bucket_prefix = var.s3_bucket_prefix

  force_destroy = true

  tags = {
    Name = "My_S3_Bucket"
  }

}

resource "aws_s3_bucket_lifecycle_configuration" "my_lifecycle_configuration" {
  bucket = aws_s3_bucket.my_s3_bucket.id
  rule {
    id = "log"
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    status = "Enabled"
  }
}


resource "aws_s3_bucket_server_side_encryption_configuration" "encryption_resource" {
  bucket = aws_s3_bucket.my_s3_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
# aws s3 rm s3://s3-csye-6225-product-image --recursive --profile dev
# aws s3 rm s3://s3-csye-6225-20230302042950945600000001 --recursive --profile dev

resource "aws_s3_bucket_public_access_block" "block_all_public_access" {
  bucket = aws_s3_bucket.my_s3_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}