provider "azurerm" {
    subscription_id     = "${var.subscription_id}"
    client_id           = "${var.client_id}"
    client_secret       = "${var.client_secret}"
    tenant_id           = "${var.tenant_id}"
}

variable "subscription_id"{
    description = "Enter subscrition id"
}

variable "client_id" {
  description = "Enter client id"
}

variable "client_secret" {
  description = "Enter Client secret"
}

variable "tenant_id" {
  description = "Enter tenant id"
}



