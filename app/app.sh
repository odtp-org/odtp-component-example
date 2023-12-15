#!/bin/bash

#########################################################
# ODTP COMPONENT TEMPLATE
#########################################################

echo "STARTING ODTP COMPONENT"

## ODTP LOGGER in the background
if [ -v ODTP_MONGO_SERVER ]; then
    echo "STARTING LOGGING IN MONGO SERVER"
    python3 /odtp/odtp-app/odtp-client/logger.py >> /odtp/odtp-logs/odtpLoggerDebugging.txt 2>&1 &
else
    echo "ODTP_MONGO_URL does not exist"
fi


############################################################################################
# START OF MANUAL CONFIGURATION. 
# ADAPT THE TEMPLATE FROM HERE.
############################################################################################

#########################################################
# GITHUB CLONING OF REPO
#########################################################

# Actions
# A1 - Clone github
git clone https://github.com/odtp-org/tool-example.git /odtp/odtp-workdir/tool-example
cd /odtp/odtp-workdir/tool-example
git checkout 79b2889

#########################################################
# IF TOOL REQUIRES A CONFIG FILE. GENERATE IT.
# IF MULTIPLE TEMPLATES AVAILABLE ADD IF STATEMENT.
#########################################################

# A2A - Prepare parameters & Config File
# Read placeholders and create config file from Environment  
#
# Not needed as this tool does not requires a config file.
# Variables will be provided when running
# python3 /odtp/odtp-app/parameters.py /odtp/odtp-app/config_templates/template.yml /odtp/odtp-workdir/config.yml
#

#########################################################
# IF TOOL REQUIRES A DATA FOLDER, CREATE SYMBOLIC LINK
# FROM VOLUME.
#########################################################

# A2B - Prepare datafolder
#
# NOT NEEDED
# ln -s /odtp/odtp-input/... /odtp/odtp-workdir/...
#

#########################################################
# COMMAND TO RUN THE TOOL
#########################################################

# A3 - Run the tool
# Here HF_DATASET IS DEFINED 
# While the output is managed by ODTP and placed in /odtp/odtp-output/
echo $HF_DATASET
python3 /odtp/odtp-workdir/tool-example/tool-example/app.py $HF_DATASET /odtp/odtp-workdir/output

# The selected output files generated should be placed in the output folder
cp -r /odtp/odtp-workdir/output/* /odtp/odtp-output

############################################################################################
# END OF MANUAL USER CONFIGURATION
############################################################################################

#########################################################
# COMPRESS THE OUTPUT FOLDER GENERATED
#########################################################

#  Take output and export it
cd /odtp/odtp-output
zip -r /odtp/odtp-output/odtp-output.zip *

#########################################################
# ODTP SNAPSHOT CREATION 
#########################################################

# Take snapshot of workdir
cd /odtp/
zip -r /odtp/odtp-output/odtp-snapshot.zip odtp-workdir


## Saving Snapshot in s3

if [[ -v ODTP_S3_SERVER && -v ODTP_MONGO_SERVER ]]; then
    echo "Uploading to ODTP_S3_SERVER"
    python3 /odtp/odtp-app/odtp-client/s3uploader.py 2>&1 | tee /odtp/odtp-logs/odtpS3UploadedDebugging.txt  
else
    echo "ODTP_S3_SERVER does not exist"
fi

echo "--- ODTP COMPONENT ENDING ---" >> /odtp/odtp-logs/log.txt

# ## Copying logs into output 
# cp /odtp/odtp-logs/log.txt /odtp/odtp-output/log.txt

# if [ -v ODTP_S3_SERVER ]; then
#     cp /odtp/odtp-logs/odtpLoggerDebugging.txt /odtp/odtp-output/odtpLoggerDebugging.txt
# else
#     echo "ODTP_S3_SERVER doesn't exist. Not copying log files."
# fi

# if [[ -v ODTP_S3_SERVER && -v ODTP_MONGO_SERVER ]]; then
#     cp /odtp/odtp-logs/odtpS3UploadedDebugging.txt /odtp/odtp-output/odtpS3UploadedDebugging.txt
# else
#     echo "ODTP_S3_SERVER doesn't exist. Not copying log files."
# fi