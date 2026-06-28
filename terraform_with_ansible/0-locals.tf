locals {
  env         = "development"
  region      = "ap-south-1"
  zone1       = "ap-south-1a"
  zone2       = "ap-south-1b"
  eks_name    = "demo"
  eks_version = "1.31"

  common_tags = {
    Project = "demo"
    Env     = "dev"
  }
}
