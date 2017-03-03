#!/bin/bash
# Describes:
#	use git+rsync simulate a auto coding publish! :)
# Author Terry
# Date 2017-02-21

deploy_home=/home/tkstorm/deploy

# include deploy functions
. ${deploy_home}/sh/deploy_functions
[ ! -d "$deploy_home" ] && cli_msg "error: deploy home dir not exist!" && exit; 
cd $deploy_home

# deploy configurage
if [ "$1" == "" ]; then
    read -p "Input want deployment website id:" website	
else
    website="$1"
fi

deploy_conf="${deploy_home}/conf/${website}/deploy.conf"
while [ ! -f "$deploy_conf" ]
do
    read -p "Error deploy configure file [$deploy_conf] not exist, retype the deployment website id:" website	
    deploy_conf="${deploy_home}/conf/${website}/deploy.conf"
    # check configure file
done

# init deploy configure
. $deploy_conf

# Step1: Check whether deployment backup codes dir need to init.
if [ ! -d "$deploy_backup" ] || [ ! -d "$ws_document" ]; then
    cli_msg "Deployment need initialize!"
    deploy_init;
fi
    
# Step2: Rsync codes 
deploy_codes && cli_msg "deploy success!" || cli_msg "deploy fail!";
