#!/bin/bash

set -e

bq mk lab

gsutil cp gs://cloud-training/gsp323/lab.csv .

gsutil cp gs://cloud-training/gsp323/lab.schema .

cat lab.schema

echo -e " $(tput setaf 99) Are you all done ? $(tput sgr 0) "
read -p " please say yes "


gcloud dataflow jobs run job1 \
    --gcs-location gs://dataflow-templates/latest/GCS_Text_to_BigQuery \
    --parameters \
javascriptTextTransformFunctionName=transform,\
JSONPath=gs://cloud-training/gsp323/lab.schema,\
javascriptTextTransformGcsPath=gs://cloud-training/gsp323/lab.js,\
inputFilePattern=gs://cloud-training/gsp323/lab.csv,\
outputTable=$DEVSHELL_PROJECT_ID:lab.customers,\
bigQueryLoadingTemporaryDirectory=gs://$DEVSHELL_PROJECT_ID/temp
