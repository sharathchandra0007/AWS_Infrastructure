locals {
  anywhere          = "0.0.0.0/0"
  web_subnets_count = length(var.web_subnets)
  db_subnets_count  = length(var.db_subnets)
  ingress_count     = length(var.web_ingress)
}