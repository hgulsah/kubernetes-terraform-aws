terraform {
  backend "s3" {
    bucket         = "gulsah-terraform-state-2026-0411-a1b2"
    key            = "environments/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

