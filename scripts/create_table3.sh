#!/bin/sh

aws dynamodb create-table \
    --table-name SlayTheReport-author-v1s \
    --attribute-definitions \
        AttributeName=author,AttributeType=S \
        AttributeName=pseudo_key,AttributeType=S \
    --key-schema \
        AttributeName=author,KeyType=HASH \
        AttributeName=pseudo_key,KeyType=RANGE \
    --provisioned-throughput \
        ReadCapacityUnits=10,WriteCapacityUnits=5 \
    --local-secondary-indexes \
        "[{\"IndexName\": \"icon_url-index\",
        \"KeySchema\":[{\"AttributeName\":\"author\",\"KeyType\":\"HASH\"},
                      {\"AttributeName\":\"pseudo_key\",\"KeyType\":\"RANGE\"}],
        \"Projection\":{\"ProjectionType\":\"INCLUDE\",  \"NonKeyAttributes\":[\"icon_url\"]}}]" 

