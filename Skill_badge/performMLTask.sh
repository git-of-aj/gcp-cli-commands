#!/bin/bash

set -e

#TASK 1 : create a dataflow job

gsutil mb gs://$DEVSHELL_PROJECT_ID

bq mk lab

gsutil cp gs://cloud-training/gsp323/lab.csv .

gsutil cp gs://cloud-training/gsp323/lab.schema .

cat lab.schema>bigquery.json

echo -e " $(tput setaf 99) A file opens in nano editor \n Delete ' { ' "
echo -e " Only leave the file ' [ '  and content within ' [ ' $(set sgr 0) "
echo " Understood ...??? Get ready "

nano bigquery.json


bq --source_format=CSV \
$DEVSHELL_PROJECT_ID:lab.customers \
gs://cloud-training/gsp323/lab.csv \
./bigquery.json

gcloud dataflow jobs run job1 \
    --gcs-location gs://dataflow-templates/latest/GCS_Text_to_BigQuery \
    --parameters \
javascriptTextTransformFunctionName=transform,\
JSONPath=gs://cloud-training/gsp323/lab.schema,\
javascriptTextTransformGcsPath=gs://cloud-training/gsp323/lab.js,\
inputFilePattern=gs://cloud-training/gsp323/lab.csv,\
outputTable=$DEVSHELL_PROJECT_ID:lab.customers,\
bigQueryLoadingTemporaryDirectory=gs://$DEVSHELL_PROJECT_ID/temp

# Please do task 2 & Task 3 manually


# Task 4
