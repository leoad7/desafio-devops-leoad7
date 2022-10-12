module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  create_vpc = true

  name = local.name
  cidr = var.cidr

  azs             = ["${local.region}a", "${local.region}b", "${local.region}c"]
  public_subnets = var.public_subnets

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

module "service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  create = true

  name        = "newsg"
  description = "Security group for NewVPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_rules            = ["https-443-tcp","http-80-tcp", "ssh-tcp"]
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  create = true

  key_name           = "keypairs"
  create_private_key = true
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  create = true

  name = "newvpc-instance"

  ami                    = "ami-08c40ec9ead489470"
  instance_type          = "t2.micro"
  key_name               = "keypairs"
  monitoring             = true
  vpc_security_group_ids = ["${module.service_sg.security_group_id}"]
  subnet_id              = element(module.vpc.public_subnets, 0)

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}