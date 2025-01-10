terraform {
  backend "s3" {
    bucket = "nk-terraform-eks"
    region = "ap-south-1"
    key    = "eks/terraform.tfstate"
  }
}
