import json
import boto3
import os
import logging


logger = logging.getLogger()
logger.setLevel(logging.INFO)

ec2 = boto3.client('ec2')
sns = boto3.client('sns')

def lambda_handler(event, context):
    # TODO implement
    logger.info("Lambda triggered")
    logger.info(event)

    instance_id = os.environ['EC2_INSTANCE_ID']

    topic_arn = os.environ['SNS_TOPIC_ARN']


    ec2.reboot_instance(InstanceIds=[instance_id])

    logger.info("Instance {} rebooted".format(instance_id))

    sns.publish(
        TopicArn=topic_arn,
        Message='Instance {} has been rebooted'.format(instance_id),
        Subject='EC2 Instance Rebooted'
    )

    logger.info("Notification sent to {}".format(topic_arn))



    return {
        'statusCode': 200,
        'message':"Reboot completed"
    }
