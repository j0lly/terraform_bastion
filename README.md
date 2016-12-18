# Terraform Bastion Host module

can be used standalone in order to test it.
Best use is with remote states (VPC at least)

This work is heavily inspired from https://github.com/widdix/aws-ec2-ssh

## You can use it standalone:

```
variable "access_key" {}
variable "secret_key" {}
variable "user_account" {}

module "bastion" {
    source = "github://j0lly/terraform_bastion"
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    user_account = "${var.user_account}"
}
```

## TODO

- conditional dns name
- remove all those provisioners lines
- support account creation filtered by groups (admins) for policy document
