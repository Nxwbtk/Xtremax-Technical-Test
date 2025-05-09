resource "aws_launch_template" "wordpress" {
    name_prefix   = "wordpress-"
    image_id = var.image_id
    instance_type = var.instance_type
    user_data = base64encode(file("${path.module}/user_data.sh"))
}