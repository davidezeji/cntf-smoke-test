#!/usr/bin/env python3

# this script uploads the local test result files (e.g. over5g.json & overinternet.json) as objects in an AWS S3 bucket.

import os
import pathlib

from glob import glob
import boto3

BASE_DIR = pathlib.Path(__file__).parent.resolve()
FILE_DIR = os.path.join(BASE_DIR)

BUCKET_NAME = 'cntf-open5gs-coralogix-test-results'
AWS_REGION = 'us-east-1'

def upload_file(file_name, bucket, object_name):
    s3_resource = boto3.resource('s3', region_name=AWS_REGION)

    if object_name is None:
        object_name = file_name
    
    s3_resource.meta.client.upload_file(file_name, BUCKET_NAME, object_name)

if __name__ == '__main__':
    file_name = os.path.join(FILE_DIR, 'over5g.json')
    upload_file(file_name=file_name, bucket=BUCKET_NAME, object_name='over5g.json')

if __name__ == '__main__':
    file_name = os.path.join(FILE_DIR, 'overinternet.json')
    upload_file(file_name=file_name, bucket=BUCKET_NAME, object_name='overinternet.json')