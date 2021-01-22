
resource "aws_instance" "wordpress" {
    ami = "${lookup(var.wordpress-images, var.region)}"

    instance_type = "t2.micro"

    security_groups = [
        "${aws_security_group.wordpress_security.name}",
    ]
    availability_zone = "${lookup(var.zones,var.region)}"


    associate_public_ip_address = true
 

}

    resource "aws_eip" "wordpress_eip"{
      instance = "${aws_instance.wordpress.id}"
      vpc = false
    }