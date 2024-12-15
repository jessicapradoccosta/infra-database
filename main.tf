provider "aws" {
  region     = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

data "aws_availability_zones" "available" {}

module "vpc" {
  source              = "terraform-aws-modules/vpc/aws"
  version             = ">= 3.0.0"
  name                = "lanchonete-fiap"
  cidr                = "10.0.0.0/16"
  azs                 = data.aws_availability_zones.available.names
  public_subnets      = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_db_subnet_group" "lanchonete_fiap" {
  name       = "lanchonete-fiap"
  subnet_ids = module.vpc.public_subnets

  tags = {
    Name = "Lanchonete Fiap"
  }
}

resource "aws_security_group" "rds" {
  name   = "lanchonete_fiap_rds"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/24", "192.168.1.0/24"]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lanchonete_fiap_rds"
  }
}

resource "aws_db_parameter_group" "lanchonete_fiap" {
  name   = "lanchonete-fiap"
  family = "postgres16"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource "aws_db_instance" "lanchonete_fiap" {
  identifier             = "lanchonete-fiap"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "16.4"
  username               = "edu"
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.lanchonete_fiap.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name   = aws_db_parameter_group.lanchonete_fiap.name
  publicly_accessible    = true
  skip_final_snapshot    = true
}
