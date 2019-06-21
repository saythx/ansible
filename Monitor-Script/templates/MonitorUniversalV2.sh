#!/bin/bash
#author : liudun
#date : 2017.8.2
#update : 2017.8.22
#update ：2017.8.29
#update ：2017.12.27 接入微信报警
#brief : 守护进程，重启拉起
#update : 2018-11-08
#brief : a)改为读取pid文件进行调用
#        b)增加启动类型

#企业微信报警
function wxalarm(){
	curl -G  --data-urlencode "user=$1" --data-urlencode "appid=trionotice" --data-urlencode "token=bcc6644ba8cfcf3284311027e18186a4" --data-urlencode "text={\"title\":\"$2\",\"alarm\":\"$3\"}"  "http://triotest.sanjiaoshou.net/Monitor/alarmapi.php"
}

#统一info log输出
function log_info(){
	echo -e "\e[32m[INFO]:[$(date +'%Y-%m-%d %H:%M:%S')]:$@\e[m"
}

#统一error log输出
function log_error(){
	echo -e "\e[31m[ERROR]:[$(date +'%Y-%m-%d %H:%M:%S')]:$@\e[m"
}

#初始化函数
function monitor_init(){
    #pid数组
    PID_ARRAY=($(awk '{print $1}' $PIDFILE | xargs))
    if [[ "$PID_ARRAY" == "" ]];then
        log_error "server.pid文件格式异常无法解析到pid！"
        exit -1
    else
        log_info "当前 PID 是 ${PID_ARRAY[@]}"
    fi
    #server名字数组
    SERVER_ARRAY=($(awk '{print $2}' $PIDFILE |xargs))
    if [[ "$SERVER_ARRAY" == "" ]];then
        SERVER_ARRAY=($(awk '{print $1}' $PIDFILE | xargs -I {} bash -c 'basename $(readlink /proc/{}/exe)' | xargs))       
    fi    
    log_info "当前 SERVER 是 ${SERVER_ARRAY[@]}"

    #端口数组
    PORT_ARRAY=()
    for i in $(seq 0 $((${#PID_ARRAY[@]}-1)))
    do
        PORT_ARRAY[$i]=$(netstat -anp | grep ${PID_ARRAY[$i]} | grep ::: |awk -F ":::" '{print $2}' | sed  's/ *//g')
    done
    log_info "服务PID、端口、名称 分别为 ${PID_ARRAY[@]} 、 ${PORT_ARRAY[@]} 、${SERVER_ARRAY[@]} "

    if [[ -f $CMD ]];then
        CMD_DIR=$(dirname $CMD)
        log_info "启动脚本目录为 $CMD_DIR"
    else
        log_error "不存在 $CMD 文件！"
        exit -1
    fi
    log_info "初始化成功！"
}

#判活函数
function pid_alive(){
    local COUNT_FLAG=0
#按pid判断服务是否正常。异常微信报警
    for ((i=0;i<${#PID_ARRAY[*]};i++))
    do
	log_info "${PID_ARRAY[$i]}"
        local ALIVE_FLAG=$(ps -ef |awk '{print $2}'| grep "^${PID_ARRAY[$i]}" | wc -l)
        if [[ $ALIVE_FLAG -eq 0  ]];then
            log_error "${SERVER_ARRAY[$i]} 不存在！"
	        wxalarm "$WX_USER" "【OnlineAlarm】 服务异常报警" "[$HOST_IP]:${SERVER_ARRAY[$i]} 服务异常终止。路径为 trio@$HOST_IP:$CMD_DIR" 
            #echo "[$(date +'%Y-%m-%d %H:%M:%S')][$HOST_IP]: ${SERVER_ARRAY[$i]} 服务异常终止。路径为 trio@$HOST_IP:$CMD_DIR" | mail -s "【OnlineAlarm】【$PROJECT】【$HOST_IP】【${SERVER_ARRAY[$i]}】【${PORT_ARRAY[$i]}】 服务异常警报！！！" "$MAIL_LIST"
            COUNT_FLAG=$(($COUNT_FLAG+1))
        fi
    done

    #全部服务正常返回 0 ；否则返回 1
    if [[ $COUNT_FLAG -gt 0 ]];then
        return 1
    else
        return 0
    fi
}

#usage
function usage(){
    echo ""
    echo -e "\e[34mUSAGE : sh MonitorUniversal.sh project pidfile command domain maillist\e[m"
    echo ""
    echo -e "  \e[34mproject\e[m 是项目名称"
    echo -e "  \e[34mpidfile\e[m 是server.pid文件路径"
    echo -e "  \e[34mcommand\e[m 为all.sh启动脚本路径"
    echo -e "  \e[34mdomain\e[m 为机器类型"
    echo -e "  \e[34mmailist\e[m 为报警接收人统一认证用户名，多人以逗号分隔"
    echo ""
}

Main(){
    if [[ $# -ne 5 ]];then
        usage
        exit -1
    fi
    PROJECT=$1
    PIDFILE=$2
    if [[ ! -f $PIDFILE ]];then
        log_error "$PIDFILE 文件不存在！"
        exit -1
    fi
    CMD=$3
    if [[ ! -f $CMD ]];then
        log_error "$CMD 文件不存在！"
        exit -1
    fi
    DOMAIN=$4
    WX_USER=$5
    MAIL_LIST=$(echo $5 |tr '[A-Z]' '[a-z]'| tr , " ")
    HOST_IP=$(hostname -i)
    INTERVAL=10    

    log_info "启动参数是 $@"
    monitor_init
    pid_alive
    
    while [[ 0 ]];do
        sleep $INTERVAL
        pid_alive
        if [[ $? -eq 0 ]];then
            log_info "当前 $INTERVAL 秒内被监控 server 都存在！"
            continue
        else        
            #单个服务异常，kill所有服务，然后重启所有服务。并微信通知服务恢复。
            log_error "监控进程出现丢失，将重启服务······"
            cd $CMD_DIR
            log_info "正在关闭子服务······"
            sh $CMD stop
            log_info "正在重启子服务······"
            sh $CMD start $DOMAIN
            cd -
            monitor_init
	        wxalarm "$WX_USER" "【~OnlineAlarm】 服务恢复通知" "[$HOST_IP]:  ${SERVER_ARRAY[@]} 已经被自动重启,端口为 ${PORT_ARRAY[@]}。请前往服务器上检查。路径为 trio@$HOST_IP:$CMD_DIR" 
            #echo "[$(date +'%Y-%m-%d %H:%M:%S')][$HOST_IP]:  ${SERVER_ARRAY[@]} 已经被自动重启,端口为 ${PORT_ARRAY[@]}。请前往服务器上检查。路径为 trio@$HOST_IP:$CMD_DIR" | mail -s "【~OnlineAlarm】【$PROJECT】【$HOST_IP】【$(echo ${SERVER_ARRAY[@]}|xargs)】服务恢复通知 " "$MAIL_LIST"
        fi
    done
}

Main $@
