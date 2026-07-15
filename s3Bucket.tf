
resource "random_string" "randstr" {
  length = 6
  upper = false
  special = false
}

resource "aws_s3_bucket" "s3bucket" {
  bucket = "tf-bucket-backend-prov-${random_string.randstr.result}"
  lifecycle {
    prevent_destroy = false
  }
  tags = {
    Name = "tf_state_${var.environment_name}_${var.region}"
    Project = "remote-backend-for-cloud-ops"
    Purpose = "terraform-backend-foundation"
  }
}

resource "aws_s3_bucket_versioning" "s3BucketVersioning" {
  bucket = aws_s3_bucket.s3bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state_encryption" {
  bucket = aws_s3_bucket.s3bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "tf_state_block_pub_access" {
  bucket = aws_s3_bucket.s3bucket.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}