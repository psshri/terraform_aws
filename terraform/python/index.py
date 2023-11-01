import json
import os

# Environment Variables
S3_BUCKET_NAME = os.environ['S3_BUCKET_NAME']
S3_KEY_PREFIX = 'json_body'

def lambda_handler(event, context):
    print(S3_BUCKET_NAME)
    print(S3_KEY_PREFIX)
    try:
        json_data = json.loads(event['body'])
        print("Recieved JSON data: ", json_data)
        return {
            'statusCode': 200,
            'body': json.dumps('Data received and printed successfully')
        }

    except Exception as e:  
        return {
            'statusCode': 500,
            'body': json.dumps('Error: ' + str(e))
        }