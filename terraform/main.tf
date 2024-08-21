module "storage" {
  source = "./modules/storage"

  account_id = data.aws_caller_identity.current.account_id
}