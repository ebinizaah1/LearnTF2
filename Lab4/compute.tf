resource "aws_instance" "web_server" {
    ami = "${lookup(var.webserver_amis, var.aws_region)}"
    instance_type = "t2.micro"

    subnet_id = "${aws_default_subnet.learntf_default_subnet.id}"

    depends_on = [ aws_s3_bucket.learntf-bins ]

    key_name = "${aws_key_pair.deployer-keypair.key_name}"

    vpc_security_group_ids = ["${aws_security_group.web_server_sec_group.id}"]

    # provisioner "remote-exec" {
      
    #   inline = [
    #     "sudo yum install -y httpd",
    #     "sudo service httpd start",
    #     "sudo groupadd www",
    #     "sudo usermod -a -G www ec2-user",
    #     "sudo usermod -a -G www apache",
    #     "sudo chown -R apache:www /var/www",
    #     "sudo chmod 770 -R /var/www"
    #   ]
    # }
 
 
    provisioner "file" {
      source= "bootstrap.sh"
      destination = "/tmp/bootstrap.sh"
    }

    provisioner "remote-exec" {
       inline = [
        "sudo chmod +x /tmp/bootstrap.sh",
        "/tmp/bootstrap.sh"
       ]
    }

    
    provisioner "file" {
      source = "learntf.indes.html"
      destination = "/var/www/html/index.html"
    }


    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = "${file("../aws_rsa")}"
      host = self.public_ip
    }

    tags = {
      "Name" = "Test_Lab2_EC2"
      "Description" = "EC2 for Lab2"
    }
  
}

output "aws_webserver_ip" {
  value = "${aws_instance.web_server.public_ip}"
}

