variable "read" {
  description = "SSM Parameter Paths to grant read access to"
  type        = list(string)
}

variable "write" {
  description = "SSM Parameter Paths to grant write access to"
  type        = list(string)
}