#!/bin/bash

# Set your Jira credentials and endpoint
JIRA_USER="mohamedcherif03@gmail.com"
JIRA_API_TOKEN="ATATT3xFfGF0gOrH703HS7ywca3xlxxt3ZsgZjdhhpLlhskh9Uug2ft39GVD6lpaBE05YWlOAZqtw9P0TCTrWpcOUlK7vc0uE4u8bqPedsYhUV8BLwyjL6myl2feo0gZ2sRldsjConk7kl-bgKu7BkqD7XyMRqFa8ILFtPmvUtzIOLwClesxlWg=577DF795"
JIRA_URL="https://ahmedselnozahy.atlassian.net/rest/api/2/search?jql=project=CCB"

# Output file
OUTPUT_FILE="jira_all.csv"

# Make API request and save the response to a file
curl -u $JIRA_USER:$JIRA_API_TOKEN -X GET -H "Content-Type: application/json" $JIRA_URL -o response.json

# Check if the response contains an error
if jq -e .errors response.json > /dev/null 2>&1; then
    echo "Error in response"
    cat response.json
    exit 1
fi

# Process the JSON response to extract the data and save it as CSV
jq -r '.issues[] | [.key, .fields.summary, .fields.assignee.displayName, .fields.status.name, (.fields.customfield_10020[0] | .id // "No Sprint"), .fields.created, .fields.updated] | @csv' response.json > $OUTPUT_FILE

# Clean up
rm response.json

echo "CSV file has been saved to $OUTPUT_FILE"
