variable "profile" {
  default = "ola-terraform"
}

variable "aws_region" {
  type = string
  default = "us-east-1"
}

data "aws_ami" "ubuntu" {
 most_recent = true
 owners = ["099720109477"]

filter {
      name   = "virtualization-type"
      values = ["hvm"]
  }

 filter {
   name   = "name"
  values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
 }
}

variable "webserver_amis" {
  type = map
}

variable "target_env" {
  default = "dev"
}