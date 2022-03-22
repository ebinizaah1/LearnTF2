provider "aws" {
  region = "${var.default_region}"
  profile = "ola-terraform"
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


resource "aws_instance" "test-instance" {
  ami = "${data.aws_ami.ubuntu.id}"
  associate_public_ip_address = true
  instance_type = "t2.micro"

  tags = {
    "Name" = "LearnTF-ec2"
    Env = "Dev"
    Description = "play_play OS"
  }
}

output "aws_instance_ip" {
 value = "${aws_instance.test-instance.public_ip}"
}

variable "default_region" {
  type = string
  default = "us-east-1"
}