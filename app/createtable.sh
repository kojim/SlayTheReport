#!/bin/sh
aws --region=ap-northeast-1 --endpoint-url=http://dynamodb:8000 dynamodb create-table --table-name SlayTheReport \
      --attribute-definitions '[
      {
          "AttributeName": "author",
          "AttributeType": "S"
      },
      {
          "AttributeName": "runid",
          "AttributeType": "S"
      },
      {
          "AttributeName": "pseudo_pk",
          "AttributeType": "S"
      },
      {
          "AttributeName": "last_modified",
          "AttributeType": "N"
      }
    ]' \
    --key-schema '[
      {
          "AttributeName": "author",
          "KeyType": "HASH"
      },
      {
          "AttributeName": "runid",
          "KeyType": "RANGE"
      }
    ]' \
    --local-secondary-indexes '[
      {
          "IndexName": "last_modified-index",
          "KeySchema": [
              {
                  "AttributeName": "author",
                  "KeyType": "HASH"
              },
              {
                  "AttributeName": "last_modified",
                  "KeyType": "RANGE"
              }
          ],
          "Projection": {
              "ProjectionType": "KEYS_ONLY"
          }
      }
    ]' \
    --global-secondary-indexes '[
       {
          "IndexName": "pseudo_pk-last_modified-index",
          "KeySchema": [
              {
                  "AttributeName": "pseudo_pk",
                  "KeyType": "HASH"
              },
              {
                  "AttributeName": "last_modified",
                  "KeyType": "RANGE"
              }
          ],
          "Projection": {
              "ProjectionType": "ALL"
          },
          "ProvisionedThroughput": {
              "ReadCapacityUnits": 1,
              "WriteCapacityUnits": 1
          }
        }
      ]' \
    --provisioned-throughput '{
      "ReadCapacityUnits": 1,
      "WriteCapacityUnits": 1
    }'
