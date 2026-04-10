terraform {
  required_version = ">= 1.0"
}

module "example_bucket" {
  source = "../../../../modules/aws/storage/s3"

  name                   = "my-example-bucket"
  encryption_enabled     = true
  sse_algorithm          = "AES256"
  bucket_key_enabled     = false
  block_public_access    = false
  website_enabled        = true
  website_index_document = "index.html"
  force_destroy          = true
  bucket_policy_json = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadObjects"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::my-example-bucket/*"
      }
    ]
  })

  lifecycle_rules = [
    {
      id     = "archive-old-objects"
      prefix = "logs/"
      transitions = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        },
        {
          days          = 90
          storage_class = "GLACIER"
        },
      ]
      expiration_days = 365
    },
  ]

  tags = {
    Environment = "dev"
    Project     = "example"
  }
}
