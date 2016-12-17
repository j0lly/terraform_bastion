resource "aws_iam_instance_profile" "bastion_profile" {
    name = "bastion_profile"
    roles = ["${aws_iam_role.role.name}"]
}

resource "aws_iam_role" "role" {
    name = "bastion_role"
    assume_role_policy = "${file("templates/role.json")}"}

resource "aws_iam_role_policy" "bastion" {
    name = "bastion"
    role = "${aws_iam_role.role.id}"
    policy = "${data.template_file.policy.rendered}"
}
