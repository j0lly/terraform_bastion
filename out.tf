output "key pair to use" {
  value = "${aws_key_pair.bastion.key_name}"
}

output "user" {
  value = "ec2-user"
}

output "eip" {
    value = "${aws_eip.bastion.public_ip}"
}
#output "hostname" {
#  value = "${aws_route53_record.bastion.name}"
#}
