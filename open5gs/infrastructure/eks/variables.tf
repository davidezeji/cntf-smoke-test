variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "cluster_name" {
  type    = string
  default = "cntf-open5gs-cluster"
}

variable "vpc_id" {
  type    = string
  default = "vpc-079d1a939306e311f"
}

variable "subnet_id" {
  type    = list(any)
  default = ["subnet-0ebdfa23a1ac3f9a6", "subnet-09d5db76f3f1e66d5"]
}

variable "desired_size" {
  type    = string
  default = "2"
}

variable "min_size" {
  type    = string
  default = "1"
}

variable "max_size" {
  type    = string
  default = "4"
}

variable "image_id" {
  type    = string
  default = "ami-00c39f71452c08778"
}

variable "instance_type" {
  type    = string
  default = "t2.large"
}

variable "marketplace-eks-role" {
  type    = string
  default = "arn:aws:iam::827704904976:role/marketplace-eks-role"
}
