# main log 수집용
resource "aws_s3_bucket" "main_logs" {
  bucket = "ssambi-main-logs"

  tags = {
    Name = "ssambi-main-logs"
  }
}