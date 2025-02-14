vpc_info = {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "main"
  }
}

web_subnets = [{
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "web-1"
  }
  }
  ,

  {

    cidr_block        = "10.0.1.0/24"
    availability_zone = "ap-south-1b"
    tags = {
      Name = "web-2"
    }
  }
]

db_subnets = [{
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "db-1"
  }

  }
  ,
  {
    cidr_block        = "10.0.3.0/24"
    availability_zone = "ap-south-1b"
    tags = {
      Name = "db-2"
    }
  }
]

web_securitygroups = {
  name        = "web-sg"
  description = "security group for web"
  tags = {
    Name = "web-sg"
  }
}

web_ingress = [{
  from_port   = 22
  to_port     = 22
  ip_protocol = "TCP"
  },
  {
    from_port   = 80
    to_port     = 80
    ip_protocol = "TCP"
  }
]

db_securitygroups = {
  name        = "db-sg"
  description = "security group for db"
  tags = {
    "Name" = "db-sg"
  }
}

db_ingress = {
  from_port   = 3306
  to_port     = 3306
  ip_protocol = "TCP"
}

keypair = {
  key_name   = "instance_key"
  public_key = "~/.ssh/id_rsa.pub"
}

instance_info = {
  ami                         = "ami-00bb6a80f01f03502"
  instance_type               = "t2.micro"
  associate_public_ip_address = "true"
  username                    = "ubuntu"
  tags = {
    Name = "web_instance"
  }
}