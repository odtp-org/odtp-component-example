#!/bin/bash
echo "RUNNING THE APP"
bash /odtp/odtp-app/app.sh 2>&1 | tee /odtp/odtp-logs/log.txt

echo "--- ODTP COMPONENT ENDING ---" >> /odtp/odtp-logs/log.txt

# Zip logs
zip -r /odtp/odtp-output/odtp-logs.zip odtp-logs