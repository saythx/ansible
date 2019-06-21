#!/bin/bash

BOTNAME=$1
TDATE=$(date +%F)
if [ -n "${BOTNAME}" ];then
  ErrNum=$(grep "^${BOTNAME}" /home/trio/Monitor/ConnectTimeout.${TDATE} | wc -l)
  echo ${ErrNum}
else 
  echo "Usage: $0 [botname]"
fi
