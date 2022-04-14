#!/bin/bash -uex

. ./config.sh
export ROLE
export FUNC
export FUNCC

export REGION=$(aws configure get region)
export ACCOUNTID=$(aws sts get-caller-identity --output text --query Account)
export ROLE_ARN="arn:aws:iam::${ACCOUNTID}:role/$ROLE"

/bin/bash
