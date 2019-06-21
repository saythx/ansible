#!/bin/bash
#check nginx status
ip=127.0.0.1:8080
function ping() {                              #用于检测nginx进程是否存在
        /sbin/pidof nginx | wc -l
}

function active() {                 #用于提取status中的active数值
        /usr/bin/curl $ip/nginx_status 2>/dev/null | sed -n '1p' | awk '{print $NF}'
}

function accepts() {            #用于提取status中的accepts数值
        /usr/bin/curl $ip/nginx_status 2>/dev/null | sed -n '3p' | awk '{print $1}'
}

function handled() {          #用于提取status中的handled数值
        /usr/bin/curl $ip/nginx_status 2>/dev/null | sed -n '3p' | awk '{print $2}'
}

function requests() {        #用于提取status中的request数值
        /usr/bin/curl $ip/nginx_status 2>/dev/null | sed -n '3p' | awk '{print $3}'
}

function reading() {        #用于提取status中的reading数值
        /usr/bin/curl $ip/nginx_status 2>/dev/null | sed -n '4p' | awk '{print $2}'
}

function writing() {        #用于提取status中的writing数值
        /usr/bin/curl $ip/nginx_status 2>/dev/null | sed -n '4p' | awk '{print $4}'
}

function waiting() {     #用于提取status中的waiting数值
        /usr/bin/curl $ip/nginx_status 2>/dev/null | sed -n '4p' | awk '{print $6}'
}

$1   #通过第一个位置参数的值来调用相应的函数  
