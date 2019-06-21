#!/bin/bash
File_name=`find $1  -cmin -1 -name $2 -maxdepth 1`
[ -n "$File_name" ] && echo 1 || echo 0
