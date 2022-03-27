resource "aws_default_subnet" "learntf_default_subnet" {
  
  availability_zone = "us-east-1a"
}

resource "aws_security_group" "web_server_sec_group" {
  name = "web server security group"


  ingress  {
    #description = "Ingress from the internet through port 22"
    from_port = 0
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  } 

    ingress  {
    from_port = 0
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  } 



  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}