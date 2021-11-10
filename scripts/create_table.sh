#!/bin/sh

aws dynamodb create-table \
    --table-name SlayTheReport-v3s \
    --attribute-definitions \
        AttributeName=author,AttributeType=S \
        AttributeName=pseudo_pk,AttributeType=S \
        AttributeName=runid,AttributeType=S \
        AttributeName=last_modified,AttributeType=N \
    --key-schema \
        AttributeName=author,KeyType=HASH \
        AttributeName=runid,KeyType=RANGE \
    --provisioned-throughput \
        ReadCapacityUnits=10,WriteCapacityUnits=5 \
    --local-secondary-indexes \
        "[{\"IndexName\": \"last_modified-index\",
        \"KeySchema\":[{\"AttributeName\":\"author\",\"KeyType\":\"HASH\"},
                      {\"AttributeName\":\"last_modified\",\"KeyType\":\"RANGE\"}],
        \"Projection\":{\"ProjectionType\":\"INCLUDE\",  \"NonKeyAttributes\":[\"run_summary\", \"report_summary\"]}}]" \
    --global-secondary-indexes \
        "[
            {
                \"IndexName\": \"pseudo_pk-last_modified-index\",
                \"KeySchema\": [{\"AttributeName\":\"pseudo_pk\",\"KeyType\":\"HASH\"},
                                {\"AttributeName\":\"last_modified\",\"KeyType\":\"RANGE\"}],
                \"Projection\":{
                    \"ProjectionType\":\"KEYS_ONLY\"
                },
                \"ProvisionedThroughput\": {
                    \"ReadCapacityUnits\": 10,
                    \"WriteCapacityUnits\": 5
                }
            }
        ]"


#       AttributeName=runfile,AttributeType=S \
#       AttributeName=run_summary,AttributeType=S \
#       AttributeName=report_summary,AttributeType=S \
#       AttributeName=report_body,AttributeType=S \
