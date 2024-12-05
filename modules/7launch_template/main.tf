resource "aws_launch_template" "lt" {
  name                   = var.launch_template_name
  instance_type          = var.instance_type
  image_id               = var.ami_id
  vpc_security_group_ids = var.security_group_ids

  user_data = (var.user_data)
}
