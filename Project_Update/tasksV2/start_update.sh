#!/bin/bash
# deploy script

if [ $# -eq 5 ];then
  if [[ $4 == "aliyun" ]];then
    ansible-playbook ABE.yml -e "update_filename=$2" -e "project_name=$1" --tags=$4
    sed -ri "s/(- hosts: )(.*)/\1${3}/"  Project_Update.yml && ansible-playbook Project_Update.yml -e "update_filename=$2" -e "project_name=$1" -e "server_flag=$5" --tags=$4
    wait
  elif [[ $4 == "bjidc" ]];then
    sed -ri "s/(- hosts: )(.*)/\1${3}/"  Project_Update.yml && ansible-playbook Project_Update.yml -e "update_filename=$2" -e "project_name=$1" -e "server_flag=$5" --tags=$4
    wait
  else
    echo "error args"
  fi
elif [ $# -eq 6 ];then
  if [[ $4 == "aliyun" ]];then
    ansible-playbook ABE.yml -e "update_filename=$2" -e "project_name=$1" --tags=$4
    sed -ri "s/(- hosts: )(.*)/\1${3}/"  Project_Update.yml && ansible-playbook Project_Update.yml -e "update_filename=$2" -e "project_name=$1" -e "server_flag=$5" -e "server_name=$6" --tags=$4
    wait
  elif [[ $4 == "bjidc" ]];then
    sed -ri "s/(- hosts: )(.*)/\1${3}/"  Project_Update.yml && ansible-playbook Project_Update.yml -e "update_filename=$2" -e "project_name=$1" -e "server_flag=$5" -e "server_name=$6" --tags=$4
    wait
  else
    echo "error args"
  fi
else
  echo "Usage: $0 <project_name> <update_filename> <update_hostip> <bjidc|aliyun> <allserver|singleserver servername> "
fi
