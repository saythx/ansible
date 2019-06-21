#!/bin/bash
# restart zabbix_agentd

killall zabbix_agentd
sleep 2
/home/trio/zabbix/sbin/zabbix_agentd
