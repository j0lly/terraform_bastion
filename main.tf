data "template_file" "policy" {
    template = "${file("${path.module}/templates/policy.json")}"
    vars {
        user_account = "${var.user_account}"
    }
}

resource "aws_eip" "bastion" {
  vpc = true
  instance = "${aws_instance.bastion.id}"
}

resource "aws_key_pair" "bastion" {
  key_name = "bastion-key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

resource "aws_instance" "bastion" {

  associate_public_ip_address = true
  instance_type = "t2.nano"
  subnet_id = "${var.subnet}"

  # adding ability to list users and get public keys from users
  iam_instance_profile = "${aws_iam_instance_profile.bastion_profile.name}"

  # base amz-linux ami for eu-west-1
  ami = "ami-9398d3e0"

  # The name of our SSH keypair we created above.
  key_name = "${aws_key_pair.bastion.key_name}"

  # Our Security group to allow SSH access only
  vpc_security_group_ids = ["${aws_security_group.bastion.id}"]

  tags {
    Name = "bastion"
    Provider = "terraform"
  }

  lifecycle { create_before_destroy = true }

  # The connection block tells our provisioner how to
  # communicate with the resource (instance)
  connection {
    # The default username for our AMI
    user = "ec2-user"
    # The connection will use the local SSH agent for authentication.
    agent = true
  }

  # Import SSH poor man syncronizer
  provisioner "file" {
    source = "${path.module}/files/installer.sh"
    destination = "/home/ec2-user/installer.sh"
  }
  provisioner "file" {
    source = "${path.module}/files/authorized_keys_command.sh"
    destination = "/home/ec2-user/authorized_keys_command.sh"
  }
  provisioner "file" {
    source = "${path.module}/files/import_users.sh"
    destination = "/home/ec2-user/import_users.sh"
  }
  provisioner "remote-exec" {
    inline = [
        "chmod +x /home/ec2-user/*.sh",
        "sudo /home/ec2-user/installer.sh",
        "sudo service sshd reload"
    ]
  }
}
