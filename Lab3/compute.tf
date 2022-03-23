

resource "aws_instance" "web_server" {
    ami = "${lookup(var.webserver_amis, var.aws_region)}"
    instance_type = "t2.micro"

    subnet_id = "${aws_default_subnet.learntf_default_subnet.id}"

    depends_on = [ aws_s3_bucket.learntf-bins ]

    tags = {
      "Name" = "Test_Lab2_EC2"
      "Description" = "EC2 for Lab2"
    }
  
}

output "aws_webserver_ip" {
  value = "${aws_instance.web_server.public_ip}"
}

