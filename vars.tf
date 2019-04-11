variable "access_key" {}
variable "secret_key" {}
variable "region" {}

variable "key_name" {}

variable "vpc_id" {
  default = "vpc-881a21f3"
}

variable "aws_id" {
  default = "ami-0057d8e6fb0692b80"
}

variable "subnet_id" {
  default = "subnet-6931a423"
}

variable "instance_type" {}
