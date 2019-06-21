#!/bin/bash
cd /home/trio/Release/Project/{{ item.project_name }}/Shell
sh TrioMonitorV2.sh stop
sh TrioMonitorV2.sh start
