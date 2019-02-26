#!/bin/sh

if [[ ! -z $S3_BUCKET ]]; then
    echo "Downloading S3 overlay from s3://$S3_BUCKET/$S3_PATH to $CATALINA_HOME"
    aws s3 cp --recursive s3://$S3_BUCKET/$S3_PATH $CATALINA_HOME
else
    echo "No S3 bucket name was provided. Please set the S3_BUCKET environment variable."
fi

$CATALINA_HOME/tomcat_start.sh
