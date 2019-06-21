#!/bin/bash
Today_T=`date -d "3 minutes ago" +%F`
Qps_file="/home/trio/Monitor/triorobot.qps.${Today_T}"
Date_Old=`date -d "3 minutes ago" +"%Y-%m-%d %H:%M:"`
Qps_All=`awk "/${Date_Old}/"'{sum += $4};END {print sum/60}' "${Qps_file}"`

if [[ $Qps_All == "" ]];then
  echo 0
else
  echo $Qps_All
fi

