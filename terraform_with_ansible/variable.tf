variable "vm_family" {
  description = "The VM family to use for the SonarQube instance."
  type        = string
  default     = "t3a.xlarge"

}

variable "disk_size" {
  description = "The size of the disk in GB for the SonarQube instance."
  type        = number
  default     = 30

}
