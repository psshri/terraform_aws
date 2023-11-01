import json
import os
import boto3
import time

# Environment Variables
S3_BUCKET_NAME = os.environ['S3_BUCKET_NAME']
S3_KEY_PREFIX = 'json_body'

s3_client = boto3.client('s3')

def lambda_handler(event, context):
    # print(S3_BUCKET_NAME)
    # print(S3_KEY_PREFIX)
    # s3_object_key = S3_KEY_PREFIX + str(int(time.time())) + '.json'
    # print(s3_object_key)

    try:
        json_data = json.loads(event['body'])

        s3_object_key = S3_KEY_PREFIX + str(int(time.time())) + '.json'

        s3_client.put_object(
            Bucket=S3_BUCKET_NAME,
            Key=s3_object_key,
            Body=json.dumps(json_data)
        )

        # print(s3_object_key)


        # print("Recieved JSON data: ", json_data)
        return {
            'statusCode': 200,
            'body': json.dumps('Request JSON Body recieved and pushed to s3 successfully')
        }

    except Exception as e:  
        return {
            'statusCode': 500,
            'body': json.dumps('Error: ' + str(e))
        }