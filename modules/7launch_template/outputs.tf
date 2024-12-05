output "launch_template_id" {
  description = "The ID of the created launch template"
  value       = aws_launch_template.lt.id
}

output "launch_template_name" {
  description = "The name of the created launch template"
  value       = aws_launch_template.lt.name
}
