# #!/bin/bash

# export AWS_DEFAULT_REGION=us-east-1
# export AWS_REGION=us-east-1
# export AWS_PAGER=
# export AWS_SECRET_ACCESS_KEY=<>
# export AWS_ACCESS_KEY_ID=<>

# python elasticsearch_service.py

# ---------------------------------------------------------------------

import boto3
import requests
from requests_aws4auth import AWS4Auth

host = 'https://vpc-es-stack-logs-infrastructure-db6yviicyfppo5obem4gv7tjdq.us-east-1.es.amazonaws.com/' # include https:// and trailing /
region = 'us-east-1' # e.g. us-west-1
service = 'es'
credentials = boto3.Session().get_credentials()
awsauth = AWS4Auth(credentials.access_key, credentials.secret_key, region, service, session_token=credentials.token)

# Register repository

path = '_snapshot/backup-logs-infrastructure-hmg' # the Elasticsearch API endpoint
url = host + path

payload = {
  "type": "s3",
  "settings": {
    "bucket": "backup-logs-infrastructure-hmg",
    "region": "us-east-1",
    "role_arn": "arn:aws:iam::254977422750:role/es-stack-logs-infrastructure-ROLE"
  }
}

headers = {"Content-Type": "application/json"}

r = requests.put(url, auth=awsauth, json=payload, headers=headers)
print(r.request.url)
print()
print(r.request.body)
print()
print(r.request.method)
print()
print(r.status_code)
print(r.text)
