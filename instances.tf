# Definimos el userdata mediante un template.
data "template_file" "userdata" {
  template = file("templates/userdata.yaml")

  vars = {
    username       = var.username
    ssh_public_key = file(var.ssh_public_key)
  }
}

# Deploy nodos administrados
resource "aws_instance" "ansible-managed-nodes" {
  #ami                    = data.aws_ssm_parameter.ami.value
  ami                    = "ami-08755c4342fb5aede"
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.vpc_talleransible_sn1.id
  vpc_security_group_ids = [aws_security_group.taller_ansible-sg.id]
  user_data              = data.template_file.userdata.rendered
  count                  = 4
  tags = {
    Name     = "nodos administrados-${count.index + 1}"
    Proyecto = "Taller de Ansible"
  }
}