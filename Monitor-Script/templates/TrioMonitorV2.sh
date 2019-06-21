#!/bin/bash

if [[ "$1" == "start" ]];then
   sh /home/trio/Monitor/MonitorUniversalV2.sh {{ item.project_name }}  server.pid /home/trio/Release/Project/{{ item.project_name }}/Shell/all.sh online {{ item.user_list }}  &>/home/trio/Monitor/log/{{ item.project_name }}.$(date +'%Y-%m-%d') &
   echo $! > monitor.pid
   exit
fi

if [[ "$1" == "stop" ]];then
   kill -9 $(cat monitor.pid)
   rm monitor.pid
fi
