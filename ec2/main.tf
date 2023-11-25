# Pulls information from vpc workspace
data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = "tatianazubco11"
    workspaces = {
      name = "vpc"
    }
  }
}

# Pulls information from rds workspace
data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = "tatianazubco11"
    workspaces = {
      name = "vpc"
    }
  }
}

# Pulls AMI information
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


# Creates EC2 instance
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id     = data.terraform_remote_state.vpc.outputs.public_subnets[0]
}