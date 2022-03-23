

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

resource "aws_instance" "bastian" {
  ami = "${lookup(var.webserver_amis, var.aws_region)}"
  instance_type = "t2.micro"

//this means that if the env is dev the count is 0 else create 1 of this resource
  count = "${var.target_env == "dev" ? 0 : 3}"
}

output "bastian_ips" {
  value = "${aws_instance.bastian.*.private_ip}"
}

output "bastian_ip_0" {
    value = "${aws_instance.bastian.*.private_ip[0]}"
  
}

data "template_file" "webserver_policy_template" {
  template = "${file("${path.module}/policy.tpl")}"

  vars = {
    "arn" = "${aws_instance.web_server.arn}"
  }
}

output "web_server_policy" {
  value = "${data.template_file.webserver_policy_template.rendered}"

}