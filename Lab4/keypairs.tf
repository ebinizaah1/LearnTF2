resource "aws_key_pair" "deployer-keypair" {
  key_name = "bootstrap-key"
  public_key = "${file("../aws_rsa.pub")}"
}