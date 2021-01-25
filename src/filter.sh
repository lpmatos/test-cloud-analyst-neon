#!/usr/bin/env bash

# ================================================
## DESCRIPTION: Base script
## AUTHOR: Lucca Pessoa da Silva Matos
# ================================================

# Make script exit when there is an error
set -o errexit

# ================================================
# VALUES
# ================================================

# High Intensity
BLACK="\033[0;90m"       # Black
RED="\033[0;91m"         # Red
GREEN="\033[0;92m"       # Green
YELLOW="\033[0;93m"      # Yellow
BLUE="\033[0;94m"        # Blue
PURPLE="\033[0;95m"      # Purple
CYAN="\033[0;96m"        # Cyan
NC="\033[0;97m"          # White

VERSION="1.0.0"
START=$(date +%s)
OS=`uname`
[ "${OS}" = "Linux" ] && DATE_CMD="date" || DATE_CMD="gdate"
DATE_INFO=$(${DATE_CMD} +"%Y-%m-%d %T")
DATE_INFO_SHORT=$(${DATE_CMD} +"%A %B")
USER=$(whoami)

SUCESS=0
BAD=1

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
RESULTS="$SCRIPTDIR/files"

# ================================================
# COMMON FUNCTIONS
# ================================================

function Status() {
  echo -e "\n[STATUS]: ${1}\n"
}

function Info() {
  echo -e "[INFO]: ${1}"
}

function Abort(){
  echo >&2 '
  ************************
  ***  ❌ ABORTED ❌  ***
  ************************
  '
  echo "An error has occurred - $1. Going out..." >&2
  exit ${BAD}
}

function Verify(){
  if [ $? -eq $SUCESS ]
  then
    Status "✅ Command executed with ${GREEN}success${NC}!"
  else
    Status "🚨 Return status not expected - Verify. Exit...${NC}" && Abort "General exception";
  fi
}

function Welcome() {
  echo -e "\n"
  echo "Setup Environment" | figlet
  echo -e "\n-------------------------------------------------"
  echo "* Welcome ${USER}! It's now ${DATE_INFO_SHORT}"
  echo -e "* ${DATE_INFO}"
  echo -e "* System - ${OS}"
  echo -e "*"
  echo -e "* Autor: ${YELLOW}Lucca Pessoa da Silva Matos${YELLOW}${NC}"
  echo -e "* Description: ${BLUE}Collecting AWS information${BLUE}${NC}"
  echo -e "* Version: ${YELLOW}${VERSION}${YELLOW}${NC}"
  echo -e "-------------------------------------------------\n"
}

function AWS(){
  if ! [ -x "$(command -v aws)" ]; then
    Status "👾 Install AWS Cli"
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    rm -rf ./aws
    rm -rf ./awscliv2.zip
    aws "$@"
  else
    aws "$@"
  fi
}

# ================================================
# AWS FUNCTIONS
# ================================================

function AWS_Describe_Instances(){
  Status "🎉 Describe all instaces"
  [ -f "$RESULTS/instances.json" ] && Status "🚨 Result instances.json alredy exist" || \
    AWS ec2 describe-instances > $RESULTS/instances.json
}

function AWS_Describe_VPCS(){
  Status "🎉 Describe all vpcs"
  [ -f "$RESULTS/vpcs.json" ] && Status "🚨 Result vpcs.json alredy exist" || \
    AWS ec2 describe-vpcs > $RESULTS/vpcs.json
}

function AWS_Describe_Subnets(){
  Status "🎉 Describe all subnets"
  [ -f "$RESULTS/subnets.json" ] && Status "🚨 Result subnets.json alredy exist" || \
    AWS ec2 describe-subnets > $RESULTS/subnets.json
}

function AWS_Describe_Subnets_VPC_Bastion(){
  Status "🎉 Describe all subnets of bastion vpc"
  [ -f "$RESULTS/subnets-vpc-bastion.json" ] && Status "🚨 Result subnets-vpc-bastion.json alredy exist" || \
    AWS ec2 describe-subnets --filter Name=vpc-id,Values=vpc-0ed406c0b66beccd3 > $RESULTS/subnets-vpc-bastion.json
}

function Main(){
  Status "👾 Home: $HOME"

  Welcome

  AWS_Describe_Instances
  AWS_Describe_VPCS
  AWS_Describe_Subnets
  AWS_Describe_Subnets_VPC_Bastion

  Verify
}

# ================================================
# MAIN
# ================================================

Main
