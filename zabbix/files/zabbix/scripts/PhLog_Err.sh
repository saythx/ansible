#!/bin/bash
# nginx log process

LOG_DIR=/home/trio/phone_log_processor/log/parse.log
STAT_TIME=$(date -d "1 minutes ago" +"%Y/%m/%d %H:%M:")

function ChkErr {
  BOTNAME=$1
  Err_Num=$(grep "${STAT_TIME}" ${LOG_DIR} | awk -v botname="${BOTNAME}" -F'\t' '{if($4==botname) print $0}' |wc -l)
  echo ${Err_Num}
}

if [ -n "$1" ];then
  ChkErr $1
else
  echo "Usage: sh $0 [botname]"
fi

