terraform {
  backend "s3" {
    bucket = "nk-terraform-eks"
    region = "ap-south-1"
    key    = "jenkins/terraform.tfstate"
  }
}