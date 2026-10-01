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
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCtBcJM9UKwGy/i5fZVwDYE+07lfaTqNag9evcRWSwRwVtHwpirT/C8NgPBPvG/yQ5Mfhiqo0kTUiveCrjkWbyPupjbZpSmYKsVCg6fytivB4xpY5SCFWbREKKxI+EUDycLOOwBGOciVhzM+cbN8qMVkYX3UTKYjt5AV1UlTY84I/3VwC6CdpGQjTokYQejdHF4TBWoK59c2qMNokUYyJNH4vO6LyStK+wLX2b7c15oJ3O99aL4dRJi2o8ez8SpGUc7CAOI2j/a4t90ukyah3HCCA6wsEereytC9nL7RK5oOyz0s0wxa6CxiE6brag7BsvKx/1rPWWxhjrsV5gkB2QgfsuogSBt5e1czVdja6e0+CB+RP2LdJ/TbHNDggCfdM5WP8S4NknMReQwS+htlpL2VJoN/NPyaYgHHgXoEosaZ/42b05wz0vx1TixQIu8+oyQ4zWJ/KHHOCiS+I3xB9KtJW2PW3/DWZ8O/UDpRe0lEHDXzgS2M9fT+cG1zBvJ4H0tF458fOlMvxNQCL2nWe9HVYBQ65yySQpjQB3U0qad8NOfPn1BsB9mzG0ewUD7R8xwzA1Z+A4voDzNlxJW7DQ1CPrO/KuzLLCUP/cVlnv1Q5uZF4W9cDQg8VvYyiZbNYOEwNCQcnsdliVtoPWj+OUwYDzWIGcR9mBXmJweShrKiw=="
}

variable "virtual_machine_size" {
    type = string
    default = "Standard_DS1_v2"
}