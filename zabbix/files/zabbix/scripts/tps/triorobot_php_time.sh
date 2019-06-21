#!/bin/bash
Robotname=$1
Today_T=`date -d "3 minutes ago" +"%F-%H"`
Php_file="/home/trio/TrioApi/TrioRobot/log/${Robotname}.${Today_T}"
Date_old=`date -d "3 minutes ago" +"%Y-%m-%d %H:%M:"`
Date_old_hour=`date -d "3 minutes ago" +"%Y-%m-%d-%H"`
Php_count=`grep REC "${Php_file}" |grep "${Date_old}"|wc -l`
Php_time_count=`grep REC "${Php_file}" |grep "${Date_old}"| awk '{sum+=$8} END  {print sum}'`

if [ $Php_count == 0 ];then
  echo 0
else
  printf "%.4f\n" `echo "scale=4; $Php_time_count / $Php_count" | bc`
fi
