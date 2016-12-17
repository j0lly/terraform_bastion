#The module has to be self contained

variable "access_key" {}
variable "secret_key" {}
variable "user_account" {
    default = ""
}

variable "region" {
    default = "eu-west-1"
}

# vpc
variable "vpc" {
    default = ""
}

# subnet
variable "subnet" {
    default = ""
}
