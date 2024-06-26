############################################################################################
# START OF MANUAL CONFIGURATION. 
# ADAPT THE TEMPLATE HERE.
############################################################################################
source "/odtp/odtp-component-client/src/shell/log.sh"
source "/odtp/odtp-component-client/src/shell/traceback.sh"
#########################################################
# GITHUB CLONING OF REPO
#########################################################

# Actions
# A1 - Clone github
odtp::print_info "Clone the  tool repo 'https://github.com/odtp-org/tool-example.git'"
git clone https://github.com/odtp-org/tool-example.git /odtp/odtp-workdir/tool-example

odtp::print_info "Move into the working directory"
cd /odtp/odtp-workdir/tool-example

odtp::print_info "Checkout commit '79b2889'"
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
odtp::print_info "download $HF_DATASET into working directory"
python3 /odtp/odtp-workdir/tool-example/tool-example/app.py $HF_DATASET /odtp/odtp-workdir/output

# The selected output files generated should be placed in the output folder
odtp::print_info "copy output from working directory into output folder"
cp -r /odtp/odtp-workdir/output/* /odtp/odtp-output

############################################################################################
# END OF MANUAL USER APP
############################################################################################
