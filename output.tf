
output "tfstate_bucket_arn" {
  value = aws_s3_bucket.s3bucket.arn
}

output "tf_state_bucket_id" {
  value = aws_s3_bucket.s3bucket.id
}