module "cognito" {
  source = "./modules/cognito"

  region         = var.region
  user_pool_name = "vehicle-sales-prod"
  domain         = "vehicle-sales-prod-auth"
}