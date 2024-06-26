variable "prefix" {
  type    = string
  default = "tfaz"
}

variable "rgName" {
  type    = string
  default = "tfaz-rg"
}

variable "location" {
  type    = string
  default = "norwayeast"
}

variable "env" {
  type    = string
  default = "dev"
}

variable "account_tier" {
  type    = string
  default = "Standard"
}

variable "account_replication_type" {
  type    = string
  default = "LRS"
}

variable "sku_name" {
  type    = string
  default = "standard"
}

variable "admin_username" {
  type    = string
  default = "adminuser"
}

variable "vm_size" {
  type    = string
  default = "Standard_B1s"
}

variable "next_hop_type" {
  type    = string
  default = "VirtualAppliance"
}

variable "rtadrprefix" {
  type    = string
  default = "0.0.0.0/0"
}