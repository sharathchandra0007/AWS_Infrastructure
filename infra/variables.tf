variable "vpc_info" {
  type = object({
    cidr_block = string
    tags       = map(string)

  })

}

variable "web_subnets" {
  type = list(object({
    cidr_block        = string
    availability_zone = string
    tags              = map(string)

  }))

}

variable "db_subnets" {
  type = list(object({
    cidr_block        = string
    availability_zone = string
    tags              = map(string)

  }))

}

variable "web_securitygroups" {
  type = object({
    name        = string
    description = string
    tags        = map(string)
  })

}

variable "web_ingress" {
  type = list(object({
    from_port   = number
    to_port     = number
    ip_protocol = string

  }))
  

}

variable "db_securitygroups" {
  type = object({
    name        = string
    description = string
    tags        = map(string)
  })

}

variable "db_ingress" {
  type = object({
    from_port   = number
    to_port     = number
    ip_protocol = string
  })

}

variable "keypair" {
  type = object({
    key_name   = string
    public_key = string

  })

}

variable "instance_info" {
  type = object({
    ami                         = string
    instance_type               = string
    associate_public_ip_address = bool
    username                    = string
    tags                        = map(string)
  })

}