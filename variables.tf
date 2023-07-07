variable "client_id" {

}
variable "client_secret" {

}
variable "tenant_id" {

}
variable "subscription_id" {

}

variable "resource_group_name" {}
variable "resource_group_location" {

}
variable "nsg_name" {

}
variable "virtual_network_name" {

}
variable "subnet_name" {

}
variable "network_interface" {
  type = list(string)
}
variable "vm_name" {
  type = list(string)

}
variable "vm_size" {

}
variable "username" {

}
variable "storage_account_type" {

}
variable "public_ip_name" {
  type = list(string)
}

