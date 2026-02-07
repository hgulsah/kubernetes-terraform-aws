terraform {
  backend "s3" {
    bucket         = "gulsah-ihtiyar-tfstate-dev-2026"
    key            = "environments/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

