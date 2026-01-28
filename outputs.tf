output "ec2" {
    description = "The ID of the EC2 instance"
    value       = aws_instance.app.id
  
}

output "lambda" {
    description = "The ARN of the Lambda function"
    value       = aws_lambda_function.reboot_lambda.arn
  
}