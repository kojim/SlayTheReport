#!/bin/sh

aws dynamodb update-table \
    --table-name SlayTheReport-v3s \
    --attribute-definitions \
        AttributeName=pseudo_pk,AttributeType=S  \
        AttributeName=last_modified,AttributeType=N  \
    --global-secondary-index-updates \
        "[
            {
		\"Create\": {
                    \"IndexName\": \"pseudo_pk-last_modified-summary\",
                    \"KeySchema\": [{\"AttributeName\":\"pseudo_pk\",\"KeyType\":\"HASH\"},
                                    {\"AttributeName\":\"last_modified\",\"KeyType\":\"RANGE\"}],
                    \"Projection\":{\"ProjectionType\":\"INCLUDE\",  \"NonKeyAttributes\":[\"run_summary\", \"report_summary\"]},
                    \"ProvisionedThroughput\": {
                        \"ReadCapacityUnits\": 10,
                        \"WriteCapacityUnits\": 5
                    }
                }
            }
        ]"


#       AttributeName=runfile,AttributeType=S \
#       AttributeName=run_summary,AttributeType=S \
#       AttributeName=report_summary,AttributeType=S \
#       AttributeName=report_body,AttributeType=S \
