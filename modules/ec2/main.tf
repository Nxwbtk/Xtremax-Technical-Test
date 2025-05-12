resource "aws_launch_template" "wordpress" {
  name_prefix   = "wordpress-"
  image_id      = var.image_id
  instance_type = var.instance_type
  user_data     = base64encode(file("${path.module}/user_data.sh"))

  iam_instance_profile {
    name = var.iam_instantce_profile
  }
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.ec2_sg.id]
  }
}
resource "aws_autoscaling_attachment" "wordpress_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.wordpress_asg.name
  lb_target_group_arn    = var.target_group_arn
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


resource "aws_security_group" "ec2_sg" {
  name   = "wordpress-ec2-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    security_groups = [
      var.sg_alb_id
    ]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "wordpress-ec2-sg"
  }
}


resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.wordpress_asg.name
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.wordpress_asg.name
}

resource "aws_cloudwatch_metric_alarm" "scale_up_alarm" {
  alarm_name          = "scale-up-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 1800
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Trigger scale up if CPU > 80% for 30 mins"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.wordpress_asg.name
  }
  alarm_actions = [aws_autoscaling_policy.scale_up.arn]
}

resource "aws_cloudwatch_metric_alarm" "scale_down_alarm" {
  alarm_name          = "scale-down-alarm"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 1800
  statistic           = "Average"
  threshold           = 40
  alarm_description   = "Trigger scale down if CPU < 20% for 30 mins"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.wordpress_asg.name
  }
  alarm_actions = [aws_autoscaling_policy.scale_down.arn]
}


