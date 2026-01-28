provider "aws" {
    region = var.aws_region
  
}

resource "aws_sns_topic" "alert" {
    name = "alert-topic"
}

resource "aws_sns_topic_subscription" "email_subscription" {
    topic_arn = aws_sns_topic.alert.arn
    protocol  = "email"
    endpoint  = "divyashah518@gmail.com"
    }

resource "aws_iam_role" "lambda_role" {
    name = "lambda-execution-role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Action    = "sts:AssumeRole"
            Effect    = "Allow"
            Principal = {
                Service = "lambda.amazonaws.com"
            }
        }]
    })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
    role       = aws_iam_role.lambda_role.id
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
    # policy = jsonencode({
    #     Version = "2012-10-17"
    #     Statement = [{
    #         Action   = "ec2:rebootInstances"
    #         Effect   = "Allow"
    #         Resource = "*"
    #     }, {
    #         Action   = "sns:Publish"
    #         Effect = "Allow"
    #         Resource = aws_sns_topic.alert.arn}]
    # })

}

resource "aws_instance" "app" {
    ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
    instance_type = "t2.micro"

    tags = {
        Name = "sumo-instance"
    }
  
}

resource "aws_lambda_function" "reboot_lambda" {
    function_name = "reboot-ec2-lambda"
    role          = aws_iam_role.lambda_role.arn
    handler       = "index.handler"
    runtime       = "python 3.10"
    filename      = "lambda_function_payload.zip"

    environment {
        variables = {
            INSTANCE_ID = aws_instance.app.id
            SNS_TOPIC_ARN = aws_sns_topic.alert.arn
        }
    }
  
}

