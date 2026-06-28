provider "aws" {
  region  = local.region
  profile = "ostad"
  # shared_config_files      = ["/home/tonmoy/.aws/config"]
  # shared_credentials_files = ["/home/tonmoy/.aws/credentials"]
}

terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.53"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.5.3"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "4.1.0"
    }
  }
}
