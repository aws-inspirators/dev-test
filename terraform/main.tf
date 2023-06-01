terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      Version = "~>3.27"
    }
  }

  required_version = ">=0.14.9"

}

provider "aws" {
  version = "~>3.0"
  region  = "east-us-1"
}

terraform {
  backend "s3" {
  bucket         = "dibo-directive-tf-state" # REPLACE WITH YOUR BUCKET NAME
  key            = "github-actions/dibo-terraform.tfstate"
  region         = "us-east-1"
  dynamodb_table = "terraform-state-locking"
  encrypt        = true
  }
}

resource "aws_s3_bucket" "s3Bucket" {
     bucket = "dibo-github-actions"
     acl       = "public-read"

     policy  = <<EOF
{
     "id" : "MakePublic",
   "version" : "2012-10-17",
   "statement" : [
      {
         "action" : [
             "s3:GetObject"
          ],
         "effect" : "Allow",
         "resource" : "arn:aws:s3:::dibo-github-actions/*",
         "principal" : "*"
      }
    ]
  }
EOF

   website {
       index_document = "index.html"
   }
}