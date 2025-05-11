output "alb_dns_name" {
  value = aws_lb.wordpress_alb.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.wordpress_target_group.arn
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}
