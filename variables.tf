
variable "environment_name" {
  description = "environment of code publish"
  type = string
  default = "dev"
}

variable "region" {
  description = "aws region"
  type = string
  default = "us-east-2"
}