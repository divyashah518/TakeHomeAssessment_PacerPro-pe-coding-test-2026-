# TakeHomeAssessment_PacerPro-pe-coding-test-2026-

## Overview
This project demonstrates:
- Log-based detection using Sumo Logic
- Automated remediation using AWS Lambda
- EC2 reboot and SNS notification
- Infrastructure definition using Terraform

## Architecture
Sumo Logic → Alert (conceptual) → Webhook → AWS Lambda → EC2 Reboot + SNS

## Sumo Logic
- Query identifies /api/data requests with response time > 3 seconds
- Alert triggers if more than 5 such requests occur within 10 minutes
- Alert is demonstrated conceptually due to tenant limitations

## AWS Lambda
- Reboots a specified EC2 instance
- Sends notification via SNS
- Logs all actions to CloudWatch
- Tested manually using simulated alert payload

## Terraform
- Defines EC2, Lambda, SNS, and IAM
- terraform init, validate, and plan were executed
- terraform apply was not run to avoid duplicating demo resources

## Recording
🎥 Demo Recording:
https://drive.google.com/file/d/1jl2ZvOeuOugSF1ZLyT5Sk00tnvdI-fXP/view?usp=sharing
