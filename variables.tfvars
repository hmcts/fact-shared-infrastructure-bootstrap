variable "product" {
  default = "fact"
}

variable "component" {
  default = "bootstrap"
}

variable "location" {
  default = "UK South"
}

variable "env" {}

variable "common_tags" {
  type = map(string)
}

variable "jenkins_AAD_objectId" {
  default = ""
}