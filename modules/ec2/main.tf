resource "aws_launch_template" "wordpress" {
  name_prefix   = "wordpress-"
  image_id      = var.image_id
  instance_type = var.instance_type
  user_data     = base64encode(file("${path.module}/user_data.sh"))

  iam_instance_profile {
    name = var.iam_instantce_profile
  }
}

resource "aws_autoscaling_group" "wordpress_asg" {
  name                = "wordpress-asg"
  min_size            = 1
  max_size            = 4
  vpc_zone_identifier = var.subnet_ids
  launch_template {
    id      = aws_launch_template.wordpress.id
    version = "$Latest"
  }
  tag {
    key                 = "website"
    value               = "wordpress-instance"
    propagate_at_launch = true
  }
}
