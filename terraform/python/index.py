import json
def lambda_handler(event, context):
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