module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  name = format("%s-%s-%s", var.environment, var.profile, var.region)

  cidr = var.public_cidr
  secondary_cidr_blocks = [
    var.private_cidr,
  ]

  azs = local.azs

  private_subnets = [for k, v in local.azs : cidrsubnet(var.private_cidr, 8, k + 1)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(var.public_cidr, 8, k + 1)]

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

}

