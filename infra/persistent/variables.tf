variable "global_configs" {
    type = object({
        resource_group_name = string
        location = string
        environment = string
        suffix = string
        project = string
    })
}