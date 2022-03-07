variable "username" {
  type    = string
  default = "ansible"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ssh_public_key" {
  type        = string
  description = "Ubicacion de la clave publica de SSH."
  default     = "files/id_rsa.pub"
}
