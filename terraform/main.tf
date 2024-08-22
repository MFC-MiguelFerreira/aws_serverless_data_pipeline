module "storage" {
  source = "./modules/storage"

  bucket_names = ["raw", "curated"]
  account_id   = local.account_id
}