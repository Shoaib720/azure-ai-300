variable "global_configs" {
    type = object({
        resource_group_name = string
        location = string
        environment = string
        suffix = string
        project = string
    })
}

variable "machine_workspace_name" {
  type = string
}

variable "virtual_machine_size" {
    type = string
    default = "Standard_DS1_v2"
}

variable "network_configs" {
  type = object({
    virtual_network_name = string
    subnet_name = string
    resource_group_name = optional(string)
  })
}

variable "aad_user_object_id" {
  type = string
}