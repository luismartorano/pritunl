# AWS
region  = "us-east-1"
profile = "terraform-udemy"

#VPC - HUB Wordpress - Name = env-profile-region
environment  = "prod"
public_cidr  = "10.32.0.0/16"
private_cidr = "10.33.0.0/16"
azs          = slice(data.aws_availability_zones.available.names, 0, 3)

############ WORDPRESS ##################
# chave
key_name = "pritunl"

# SecurityGroup
instance_sg_name = "pritunl-sg"


# EC2
instance_name = "pritunl"
ami           = "ami-053b0d53c279acc90"
instance_type = "t2.micro"
##########################################

# alb
alb_tg_name  = "pritunl-tg"
alb_alb_name = "pritunl-alb"

# Route53
#domain_name = "pritunl.martorano.dev"
#domain_root = "martorano.dev"
