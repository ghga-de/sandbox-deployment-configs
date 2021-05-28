variable "kube_config" {
  description = "Path to kube config"
  default     = ""
}

variable "kube_context" {
  description = "Name of kube context"
  default     = ""
}

variable "postgresql_postgres_password" {
  description = "PostgreSQL admin password"
  default     = ""
}
variable "postgresql_username" {
  description = "PostgreSQL username"
  default     = ""
}

variable "postgresql_password" {
  description = "PostgreSQL user password"
  default     = ""
}
