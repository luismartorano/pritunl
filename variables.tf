variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "public_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "private_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
}

variable "vpc_tags" {
  description = "Tags for the VPC"
  type        = map(string)
  default     = {}
}

variable "subnet_tags" {
  description = "Tags for the subnets"
  type        = map(string)
  default     = {}
}

variable "route_table_tags" {
  description = "Tags for the route tables"
  type        = map(string)
  default     = {}
}

variable "nat_gateway_tags" {
  description = "Tags for the NAT gateways"
  type        = map(string)
  default     = {}
}

variable "region" {
  description = "Região da AWS que iremos trabalhar"
  type        = string

}

variable "profile" {
  description = "Profile configurado da AWS na sua máquina que iremos trabalhar"
  type        = string

}

variable "key_name" {
  description = "Nome para cheve"
  type        = string

}


variable "instance_sg_name" {
  description = "Nome para o security group para instancia"
  type        = string

}

variable "instance_name" {
  description = "Nome da instância"
  type        = string

}

variable "ami" {
  description = "Ami da ec2"
  type        = string

}

variable "instance_type" {
  description = "Tipo da instância"
  type        = string

}

variable "alb_tg_name" {
  description = "Nome do TargetGroup"
  type        = string

}

variable "alb_alb_name" {
  description = "Nome do Application LoadBalancer"
  type        = string

}

#variable "domain_root" {
#  description = "Dominio principal do Route53"
#  type        = string
#}
#
#variable "domain_name" {
#  description = "Domínio que vou utilizar"
#  type        = string
#
#}





