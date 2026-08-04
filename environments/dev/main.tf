module "cognito" {
  source = "../../modules/cognito"

  region         = var.region
  user_pool_name = "vehicle-sales-dev"
  domain         = "vehicle-sales-dev-auth"
}
