#!/bin/bash
set -euo pipefail

environment=$1
compartment_id=$2
aws_access_key_id=$3
aws_secret_access_key=$4
# ID=$(az account show | jq -r .tenantId | cut -d '-' -f1)
# RESOURCE_GROUP_NAME=${environment}tfstate
# STORAGE_ACCOUNT_NAME=${environment}tfstate$ID
# CONTAINER_NAME=${environment}tfstate

BUCKET_NAME=${environment}tfstate

NAMESPACE=$(oci os ns get --query "data" --raw-output)
# REGION=$(oci iam region-subscription list --query "data[?\"is-home-region\"].\"region-name\" | [0]" --raw-output)

# Set for testing
REGION='ap-osaka-1'

S3_ENDPOINT=https://${NAMESPACE}.compat.objectstorage.${REGION}.oraclecloud.com

# Create compartment


# Create bucket
oci os bucket create --compartment-id <compartment_id> --name $BUCKET_NAME

echo "export REMOTE_STATE_S3_BUCKET=$BUCKET_NAME" > tf.sh
echo "export REMOTE_STATE_S3_REGION=$REGION" >> tf.sh
echo "export REMOTE_STATE_S3_ENDPOINT=$S3_ENDPOINT" >> tf.sh
echo "export AWS_REGION=$REGION" >> tf.sh
echo "export AWS_ACCESS_KEY_ID=$aws_access_key_id" >> tf.sh
echo "export AWS_SECRET_ACCESS_KEY=$aws_secret_access_key" >> tf.sh
echo "export AWS_ENDPOINT_URL_S3=$S3_ENDPOINT" >> tf.sh

echo -e "\nIf you need to run terraform commands manually, run the following command in your terminal to export the necessary environment variables"

echo "\nsource tf.sh"