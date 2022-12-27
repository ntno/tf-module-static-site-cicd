variable "read" {
  description = "SSM Parameter Paths to grant read access to"
  type        = list(string)
}

variable "write" {
  description = "SSM Parameter Paths to grant write access to"
  type        = list(string)
}

variable "policy_name" {
  description = "IAM Policy Name"
  type        = string
}

variable "policy_description" {
  description = "IAM Policy Description"
  type        = string
}

variable "role_name" {
  description = "IAM Role to attach policy to"
  type        = string
}

variable "policy_path" {
  description = "IAM path for policy"
  type        = string
  default     = "/CustomerManaged/"
}

variable "tags" {
  description = "Tags to set"
  type        = map(string)
  default     = {}
}
