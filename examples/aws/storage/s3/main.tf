terraform {
  required_version = ">= 1.0"
}

module "example_bucket" {
  source = "../../../../modules/aws/storage/s3"

  name               = "my-example-bucket"
  versioning_enabled = true
  force_destroy      = true

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
