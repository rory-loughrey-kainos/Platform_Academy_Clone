variable "root_name" {
  type        = string
  default     = "rl-webapp-"
  description = "rory's webapp root naming"
}

variable "location" {
  type        = string
  default     = "eastus"
  description = "general location for resources"
}

variable "vnet_address_space" {
  type        = list(string)
  default     = ["10.0.0.0/16"]
  description = "webapp vnet address space"
}

variable "webapp_subnet_space" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "webapp subnet address space"
}

variable "keyvault_subnet_space" {
  type        = list(string)
  default     = ["10.0.3.0/24"]
  description = "keyvault subnet address space"
}

variable "db_subnet_space" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "database subnet address space"
}

variable "bastion_subnet_space" {
  type        = list(string)
  default     = ["10.0.4.0/26"]
  description = "bastion subnet address space"
}

variable "vm_subnet_space" {
  type        = list(string)
  default     = ["10.0.5.0/26"]
  description = "vm subnet address space"
}

variable "dns_ip" {
  type        = string
  default     = "168.63.129.16"
  description = "ip for dns service"
}

variable "code_repo" {
  type        = string
  default     = "https://github.com/Azure-Samples/nodejs-docs-hello-world"
  description = "code repo for webapp"
}

variable "tenant_id" {
  type        = string
  default     = "396f479c-75a6-4b53-bc03-35f5e13524dc"
  description = "azure tenant id"
}