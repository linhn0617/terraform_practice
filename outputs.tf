output "bastion_ssh_command" {
  value = "ssh -i ~/.ssh/id_rsa ubuntu@${aws_instance.bastion.public_ip}"
}

output "private_ssh_via_bastion" {
  value = "ssh -i ~/.ssh/id_rsa -J ubuntu@${aws_instance.bastion.public_ip} ubuntu@${aws_instance.private_instance.private_ip}"
}