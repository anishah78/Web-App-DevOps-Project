variable "instance_type" {
  description = "The type of EC2 instance to create."
  type        = string
  default     = "t2.micro"
}

variable "my_IP" {
  type        = string
  description = "Address space for the Virtual Network (VNet)."
  default     = "82.31.245.149"  # Provided a default value for the source address
}