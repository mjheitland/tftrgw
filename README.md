This Terraform project shows how to specify and deploy the following components:
+ 1 keypair (first you have to run ssh-keygen in your home folder)
+ 2 VPCs (each one with 1 internet gateway, 1 public subnet, 1 public security group allowing ssh, ping and icmp, 1 public route table with its main route table association and 1 ec2 instance)
+ 1 transit gateway with two transit gateway attachments (which connect a vpc subnet with the transit gateway)

## generate a keypair to access EC2 instances

    ssh-keygen

## Terraform commands
    
    terraform init
    
    terraform validate
    
    terraform plan -out=tfplan
    
    terraform apply -auto-approve tfplan
    
    terraform apply -auto-approve
    
    terraform destroy -auto-approve

## To delete Terraform state files
    rm -rfv **/.terraform # remove all recursive subdirectories
    