FROM ubuntu:22.04

RUN apt-get update
RUN apt-get install python3.10 python3-pip -y

##################################################
# Ubuntu setup
##################################################

RUN  apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get -y upgrade \
  && apt-get install -y --no-install-recommends \
    unzip \
    nano \
    git \ 
    g++ \
    gcc \
    htop \
    zip \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

##################################################
# ODTP setup
##################################################

COPY odtp-component-client/requirements.txt /tmp/odtp.requirements.txt
RUN pip install -r /tmp/odtp.requirements.txt


#######################################################################
# PLEASE INSTALL HERE ALL SYSTEM DEPENDENCIES RELATED TO YOUR TOOL
#######################################################################

# Installing dependecies from the app
COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt


######################################################################
# ODTP COMPONENT CONFIGURATION. 
# DO NOT TOUCH UNLESS YOU KNOW WHAT YOU ARE DOING.
######################################################################

##################################################
# ODTP Preparation
##################################################

RUN mkdir /odtp \
    /odtp/odtp-config \
    /odtp/odtp-app \
    /odtp/odtp-component-client \
    /odtp/odtp-logs \ 
    /odtp/odtp-input \
    /odtp/odtp-workdir \
    /odtp/odtp-output 


# This copy all the information for running the ODTP component
COPY odtp.yml /odtp/odtp-config/odtp.yml

COPY ./odtp-component-client /odtp/odtp-component-client

COPY ./app /odtp/odtp-app
WORKDIR /odtp

# Avoid error when building on windows
RUN sed -i 's/\r$//' /odtp/odtp-component-client/src/shell/log.sh
RUN sed -i 's/\r$//' /odtp/odtp-component-client/src/shell/traceback.sh
RUN sed -i 's/\r$//' /odtp/odtp-component-client/scripts/component-update.sh
RUN sed -i 's/\r$//' /odtp/odtp-component-client/odtp-app.sh
RUN sed -i 's/\r$//' /odtp/odtp-component-client/startup.sh
RUN sed -i 's/\r$//' /odtp/odtp-app/app.sh

ENTRYPOINT ["bash", "/odtp/odtp-component-client/startup.sh"]
