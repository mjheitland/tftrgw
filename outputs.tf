#--- root/outputs.tf ---
output "project_name" {
  value = var.project_name
}

#--- networking
output "vpc1_id" {
  value = module.networking.vpc1_id
}
output "igw1_id" {
  value = module.networking.igw1_id
}
output "subpub1_id" {
  value = module.networking.subpub1_id
}
output "sgpub1_id" {
  value = module.networking.sgpub1_id
}
output "rtpub1_id" {
  value = module.networking.rtpub1_id
}
output "rtpub1assoc_id" {
  value = module.networking.rtpub1assoc_id
}
output "vpc2_id" {
  value = module.networking.vpc2_id
}
output "igw2_id" {
  value = module.networking.igw2_id
}
output "subpub2_id" {
  value = module.networking.subpub2_id
}
output "sgpub2_id" {
  value = module.networking.sgpub2_id
}
output "rtpub2_id" {
  value = module.networking.rtpub2_id
}
output "rtpub2assoc_id" {
  value = module.networking.rtpub2assoc_id
}

#--- compute
output "keypair_id" {
  value = module.compute.keypair_id
}
output "server1_ids" {
  value = module.compute.server1_ids
}
output "server1_public_ips" {
  value = module.compute.server1_public_ips
}
output "server2_ids" {
  value = module.compute.server2_ids
}
output "server2_public_ips" {
  value = module.compute.server2_public_ips
}
