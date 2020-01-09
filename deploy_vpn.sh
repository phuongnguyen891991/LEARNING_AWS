#!/bin/sh

# the command as belows is using for:
# - download scripts file for auto start.
# - start a virtual machine
# - deploy vpn server
curl -s https://raw.githubusercontent.com/AWSinAction/code2/master/chapter05/vpn-create-cloudformation-stack.sh | bash -ex

# terminate virtual machine and stop vpn
aws cloudformation delete-stack --stack-name vpn

#create an application for the AWS Elastic Beanstalk service:
aws elasticbeanstalk create-application --application-name etherpad

#You can create a new version of your Etherpad application with the following command:
aws elasticbeanstalk create-application-version --application-name etherpad --version-label 1 --source-bundle "S3Bucket=awsinaction-code2,S3Key=chapter05/etherpad.zip"

# command will help you track the state of your Etherpad environment:
aws elasticbeanstalk describe-environments --environment-names etherpad
aws elasticbeanstalk describe-environments --environment-names etherpad --output text --query "Environments[].Status"

# list all solution stack
aws elasticbeanstalk list-available-solution-stacks

aws elasticbeanstalk list-available-solution-stacks --output text --query "SolutionStacks[?contains(@, 'running Node.js')] | [0]" 64bit Amazon Linux 2017.03 v4.2.1 running Node.js

# clean up elastic beanstalk
aws elasticbeanstalk terminate-environment --environment-name etherpad

#Wait until Status has changed to Terminated, and then proceed with the following command:
aws elasticbeanstalk delete-application --application-name etherpad
