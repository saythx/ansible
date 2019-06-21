#!/bin/bash
RobotName=$1
Today_T=`date -d "3 minutes ago" +%F`
Qps_file="/home/trio/Monitor/triorobot.qps.${Today_T}"
DAte_old=`date -d "3 minutes ago" +"%Y-%m-%d %H:%M:"`
RObot_qps=`grep "${RobotName}" "${Qps_file}" | grep "${DAte_old}" | awk '{sum+=$4}END{print sum/60}'`
if [[ $RObot_qps == '' ]];then
  echo 0
else
  echo $RObot_qps
fi

