import json
import logging
import os
from datetime import datetime

import boto3
import requests

logging.basicConfig()
logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

raw_bucket_name = os.environ.get("raw_bucket_name")

def handler(event, context):
    logger.info(f"Starting the extract lambda")

    currency = event["currency"]
    logger.info(f"Getting information about currency exchange: {currency}")

    response = requests.get(url=f"https://economia.awesomeapi.com.br/json/last/{currency}")
    logger.info(f"Request status code: {response.status_code}")

    if response.status_code ==  200:
        currency = currency.replace("-", "")
        ingestion_datetime = datetime.now()
        response_json = response.json()[currency]
        response_json["ingestion_datetime"] = str(ingestion_datetime)
        logger.info(f"Request ingestion datetime: {ingestion_datetime}")
        
        s3 = boto3.client("s3")
        year, month, day, hour, minute = f"{ingestion_datetime.year:04}", f"{ingestion_datetime.month:02}", f"{ingestion_datetime.day:02}", f"{ingestion_datetime.hour:02}", f"{ingestion_datetime.minute:02}"
        object_key = f"currency_exchange/currency={currency}/date={year}{month}{day}/{hour}{minute}.json"
        s3.put_object(
            Bucket=raw_bucket_name,
            Key=object_key,
            Body=json.dumps(response_json, ensure_ascii=False),
            ContentType="application/json"
        )
        logger.info(f"Object uploaded to: {object_key}")
    else:
        raise Exception(response.content)

    logger.info(f"Ending the extract lambda")
