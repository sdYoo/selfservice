terraform {
    backend "s3" {
      bucket         = "ssambi-tfstate" # s3 bucket 이름
      key            = "terraform.tfstate" # s3 내에서 저장되는 경로를 의미합니다.
      region         = "us-east-1"
      encrypt        = true
      dynamodb_table = "terraform-lock"
    }
}

# S3 bucket for backend 백엔드 저장
resource "aws_s3_bucket" "tfstate" {
  bucket = "ssambi-tfstate"

  tags = {
    Name = "ssambi-tfstate"
  }

  versioning {
    enabled = true # Prevent from deleting tfstate file
  }
}

