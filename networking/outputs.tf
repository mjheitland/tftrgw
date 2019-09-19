#--- networking/outputs.tf ---
output "vpc1_id" {
  value = aws_vpc.vpc1.id
}
output "igw1_id" {
  value = aws_internet_gateway.igw1.id
}
output "subpub1_ids" {
  value = aws_subnet.subpub1.*.id
}
output "sgpub1_id" {
  value = aws_security_group.sgpub1.id
}
output "rtpub1_ids" {
  value = aws_route_table.rtpub1.*.id
}
output "rtpub1assoc_id" {
  value = aws_route_table_association.rtpub1assoc.id
}

output "vpc2_id" {
  value = aws_vpc.vpc2.id
}
output "igw2_id" {
  value = aws_internet_gateway.igw2.id
}
output "subpub2_ids" {
  value = aws_subnet.subpub2.*.id
}
output "sgpub2_id" {
  value = aws_security_group.sgpub2.id
}
output "rtpub2_ids" {
  value = aws_route_table.rtpub2.*.id
}
output "rtpub2assoc_id" {
  value = aws_route_table_association.rtpub2assoc.id
}
