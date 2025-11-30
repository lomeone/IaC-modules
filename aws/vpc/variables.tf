variable "name" {
  type = object({
    vpc                               = string
    public_subnet                     = string
    eks_control_plane_subnet          = string
    private_subnet                    = string
    db_private_subnet                 = string
    pod_custom_networking_subnet      = string
    eks_control_plane_route_table     = string
    public_route_table                = string
    private_route_table               = string
    db_route_table                    = string
    pod_custom_networking_route_table = string
    internet_gateway                  = string
    public_nat_gateway                = string
    eks                               = string
  })
  default = {
    vpc                               = "default"
    public_subnet                     = "public"
    eks_control_plane_subnet          = "eks-control-plane"
    private_subnet                    = "private"
    db_private_subnet                 = "db-private"
    pod_custom_networking_subnet      = "pod-custom-networking"
    eks_control_plane_route_table     = "eks-control-plane-rtb"
    public_route_table                = "public-rtb"
    private_route_table               = "private-rtb"
    db_route_table                    = "db-rtb"
    pod_custom_networking_route_table = "pod-custom-networking-rtb"
    internet_gateway                  = "igw"
    public_nat_gateway                = "nat-public-gw"
    eks                               = "default"
  }
  description = "resource names"
}

variable "cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "vpc base cidr"
}

variable "pod_custom_networking_cidr" {
  type        = string
  default     = "100.64.0.0/17"
  description = "pod custom networking cidr"
}

variable "availability_zone_count" {
  type        = number
  default     = 3
  description = "availability zone count"
}

variable "subnet_cidr" {
  type = object({
    public                = list(string)
    eks_control_plane     = list(string)
    private               = list(string)
    db_private            = list(string)
    pod_custom_networking = list(string)
  })
  default = {
    public                = []
    eks_control_plane     = []
    private               = []
    db_private            = []
    pod_custom_networking = []
  }
  description = "subnet cidr"
}
