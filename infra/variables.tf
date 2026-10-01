variable "global_configs" {
    type = object({
        resource_group_name = string
        location = string
        environment = string
        suffix = string
        project = string
    })
}

variable "ssh_key" {
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILQRySEihqLcb9FvJpvJhy3LfyOn4fTreftyUezGvbnO"
}

variable "virtual_machine_size" {
    type = string
    default = "Standard_DS1_v2"
}