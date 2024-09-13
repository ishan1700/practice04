provider "aws" {
  region = "us-east-1"  # Change this to your preferred AWS region
}

# S3 bucket for storing Elastic Beanstalk application versions
resource "aws_s3_bucket" "elastic_beanstalk" {
  bucket = "my-elastic-beanstalk-app-bucket"  # Ensure this bucket name is globally unique
}

# Elastic Beanstalk Application
resource "aws_elastic_beanstalk_application" "example" {
  name        = "my-elastic-beanstalk-app"
  description = "My Elastic Beanstalk Application"
}

# Elastic Beanstalk Application Version
resource "aws_elastic_beanstalk_application_version" "example" {
  name        = "v1"
  application = aws_elastic_beanstalk_application.example.name
  bucket      = aws_s3_bucket.elastic_beanstalk.bucket
  key         = "application-version.zip"  # Path to your application version in the S3 bucket
}

# Elastic Beanstalk Environment
resource "aws_elastic_beanstalk_environment" "example" {
  name                = "my-elastic-beanstalk-env"
  application         = aws_elastic_beanstalk_application.example.name
  solution_stack_name = "64bit Amazon Linux 2 v3.4.11 running Python 3.8"  # Example platform, adjust as needed

 
  version_label = aws_elastic_beanstalk_application_version.example.name
}

# Security Group for Elastic Beanstalk Environment
resource "aws_security_group" "elastic_beanstalk" {
  name        = "elastic-beanstalk-sg"
  description = "Security group for Elastic Beanstalk environment"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
