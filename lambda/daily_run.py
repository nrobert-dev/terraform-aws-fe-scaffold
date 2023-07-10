import boto3
import datetime
import os

def lambda_handler(event, context):
    # Generate a unique HTML file name
    current_time = datetime.datetime.now().strftime("%Y%m%d-%H%M")
    html_file_name = f"html_file_{current_time}.html"

    # HTML content
    html_content = """
    <!DOCTYPE html>
    <html>
    <head>
        <title>My Unique HTML File</title>
    </head>
    <body>
        <h1>Hello, world!</h1>
        <p>This HTML file was generated at {}.</p>
    </body>
    </html>
    """.format(current_time)

    # Upload the HTML file to the S3 bucket
    s3 = boto3.client('s3')
    bucket_name = os.environ['BUCKET_NAME']  # Read bucket name from environment variable
    s3.put_object(Body=html_content, Bucket=bucket_name, Key=html_file_name, ContentType='text/html')

    return {
        'statusCode': 200,
        'body': 'HTML file uploaded successfully.'
    }
