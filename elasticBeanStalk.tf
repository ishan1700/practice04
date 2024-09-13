#S3 bucket for storing Elastic Beanstalk application versions
resource "aws_s3_bucket" "healthApp-Elastic-Beanstalk" {
  bucket = "healthApp-Elastic-Beanstalk"
}