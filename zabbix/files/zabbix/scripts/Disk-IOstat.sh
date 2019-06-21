#!/bin/bash
iostat -d $1 -x|grep "${1}" |awk  '{print $NF}'
