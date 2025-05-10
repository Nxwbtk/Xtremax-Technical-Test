output "instance_profile_name" {
  value = aws_iam_instance_profile.wordpress_instance_profile.name
}
output "role_name" {
  value = aws_iam_role.ec2_role.name
}
