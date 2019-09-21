#--- compute/variables.tf
variable "project_name" {
  description = "project name is used as resource tag"
  type        = string
}
variable "key_name" {
  description = "name of keypair to access ec2 instances"
  type        = string
}
variable "public_key_path" {
  description = "file path on deployment machine to public rsa key to access ec2 instances"
  type        = string
}
variable "subpub1_id" {
  description = "id of public subnets"
  type        = string
}
variable "sgpub1_id" {
  description = "id of security group"
  type        = string
}

variable "subpub2_id" {
  description = "id of public subnets"
  type        = string
}
variable "sgpub2_id" {
  description = "id of security group"
  type        = string
}
