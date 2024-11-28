resource "aws_s3_bucket" "test" {
  bucket = "spylyp-test-tf"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
