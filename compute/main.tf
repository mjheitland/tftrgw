#--- compute/main.tf
resource "aws_key_pair" "keypair" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

data "aws_ami" "server_ami" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn-ami-hvm*-x86_64-gp2"]
  }
}

#--- Server 1
data "template_file" "userdata1" {
  template = file("${path.module}/userdata.tpl")
  vars = {
    server_number = "1"
  }
}
resource "aws_instance" "server1" {
  instance_type           = "t2.micro"
  ami                     = data.aws_ami.server_ami.id
  key_name                = aws_key_pair.keypair.id
  subnet_id               = var.subpub1_id
  vpc_security_group_ids  = [var.sgpub1_id]
  user_data               = data.template_file.userdata1.*.rendered[0]
  tags = { 
    name = format("%s_server1", var.project_name)
    project_name = var.project_name
  }
}


#--- Server 2
data "template_file" "userdata2" {
  template = file("${path.module}/userdata.tpl")
  vars = {
    server_number = "2"
  }
}
resource "aws_instance" "server2" {
  instance_type           = "t2.micro"
  ami                     = data.aws_ami.server_ami.id
  key_name                = aws_key_pair.keypair.id
  subnet_id               = var.subpub2_id
  vpc_security_group_ids  = [var.sgpub2_id]
  user_data               = data.template_file.userdata2.*.rendered[0]
  tags = { 
    name = format("%s_server2", var.project_name)
    project_name = var.project_name
  }
}
