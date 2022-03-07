output "userdata" {
  value = "\n ${data.template_file.userdata.rendered}"
}

output "PublicIP" {
  value = element(aws_instance.ansible-managed-nodes.*.public_ip, 0)
}