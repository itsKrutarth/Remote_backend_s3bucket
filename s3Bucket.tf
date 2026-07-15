
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