

resource "aws_instance" "web_server" {
    ami = "${lookup(var.webserver_amis, var.aws_region)}"
    instance_type = "t2.micro"

    tags = {
      "Name" = "Test_Lab2_EC2"
      "Description" = "EC2 for Lab2"
    }
  
}

output "aws_" {
  value = "${aws_instance.web_server.public_ip}"
}