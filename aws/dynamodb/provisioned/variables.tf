variable "name" {
  type = string
}

variable "capacity" {
  type = object({
    min_read_unit  = number
    min_write_unit = number
    max_read_unit  = number
    max_write_unit = number
  })
}

variable "partition_key" {
  type = object({
    name = string,
    type = string
  })
}

variable "sort_key" {
  type = object({
    name = string
    type = string
  })
  default = {
    name = null
    type = null
  }
}
