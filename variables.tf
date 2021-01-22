
variable "local_ip" {
    type = "string"
}

variable "region" {
    type = "string"
}
variable "wordpress-images" {
    type = "map"
    
    default = {
        "us-east-1" = "ami-0b33d91d"
    }
}
variable "zones" {
    type = "map"
    
    default = {
        "us-east-1" = "us-east-1b"
    }
}
