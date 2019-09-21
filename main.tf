#--- root/main.tf ---
provider "aws" {
  region = "eu-central-1"
}

# deploy networking resources
module "networking" {
  source        = "./networking"
  
  project_name  = var.project_name
}

# Deploy Compute Resources
module "compute" {
  source          = "./compute"
  
  project_name    = var.project_name
  key_name        = var.key_name
  public_key_path = var.public_key_path

  subpub1_id      = module.networking.subpub1_id
  sgpub1_id       = module.networking.sgpub1_id
  
  subpub2_id     = module.networking.subpub2_id
  sgpub2_id       = module.networking.sgpub2_id
}
