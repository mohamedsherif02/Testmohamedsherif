@echo off
setlocal

REM Set your Jira credentials and endpoint
set "JIRA_USER=ahmeds.elnozahy@gmail.com"
set "JIRA_API_TOKEN=ATATT3xFfGF0hAyV6gXAlbYVNZfU5drSW-nUtEeitDa1SEg4frpd50-LOr48uJIUGCgtyRlgah_T740q_kbj45x6HLRuBR6FPnleO_tZQ3f1jNITL6myMBJUyQIjDHa_TLFvHkfdtR2Ui88NV_GrENwq-BWwspdzk8yLvRCbLSc2OjQwluMR_9U=319AB789"
set "JIRA_URL=https://ahmedselnozahy.atlassian.net/rest/api/2/search?jql=project=CCB"

REM Output file
set "OUTPUT_FILE=jira_timeline.csv"

REM Make API request and save the response to a file
curl -u %JIRA_USER%:%JIRA_API_TOKEN% -X GET -H "Content-Type: application/json" %JIRA_URL% -o response.json

REM Check if the response contains an error
jq -e .errors response.json >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo Error in response
    type response.json
    exit /b 1
)

REM Process the JSON response to extract the data and save it as CSV
jq -r ".issues[] | [.key, .fields.summary, .fields.assignee.displayName, .fields.status.name, .fields.created, .fields.updated] | @csv" response.json > %OUTPUT_FILE%

REM Clean up
del response.json

echo CSV file has been saved to %OUTPUT_FILE%

endlocal
pause
