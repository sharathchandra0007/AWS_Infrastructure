resource "aws_key_pair" "newkey" {
  key_name   = var.keypair.key_name
  public_key = file(var.keypair.public_key)

}

resource "aws_instance" "web_instance" {
  ami                         = var.instance_info.ami
  instance_type               = var.instance_info.instance_type
  key_name                    = var.keypair.key_name
  vpc_security_group_ids      = [aws_security_group.web-sg.id]
  associate_public_ip_address = var.instance_info.associate_public_ip_address
  subnet_id                   = aws_subnet.web[0].id
  tags                        = var.instance_info.tags



}

resource "null_resource" "null" {
  triggers = {
    build_id = "1"
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = aws_instance.web_instance.public_ip
  }
  provisioner "remote-exec" {
    script = "./script.sh"

  }
}