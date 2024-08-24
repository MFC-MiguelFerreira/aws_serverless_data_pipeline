output "bucket_ids" {
  value = module.storage.bucket_ids
}

output "ecr_repository_name" {
  value = module.ecr.repository_name
}

output "ecr_docker_image_uri" {
  value = module.docker_image.image_uri
}
