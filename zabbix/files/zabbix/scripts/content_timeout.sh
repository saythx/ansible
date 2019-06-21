#!/bin/bash

cd /home/trio/TrioApi/TrioBrain/log

CUR_TIME=`date  "+%F %H:%M"`
AGO_TIME=`date -d '5 minutes ago'  "+%F %H:%M"`
LOG_TIME=`date -d '5 minutes ago'  "+%F-%H"`

BOTNAMES=(content_soccer_players content_soccer_teams content_TravelPOI content_TravelLocation content_videoname content_FlightNum content_News content_book content_shopping content_people)


function wxalarm(){
  curl -G  --data-urlencode "user=trio" --data-urlencode "appid=trionotice" --data-urlencode "token=bcc6644ba8cfcf3284311027e18186a4" --data-urlencode "text={\"title\":\"【北京机房】 内容平台服务请求超时\",\"alarm\":\"超时的BotName: ${1} </div><div>超时的个数：${2}\"}"  "http://triotest.sanjiaoshou.net/Monitor/alarmapi.php"
}



function content_bot() {
  case $1 in 
    content_soccer_players)
      TIMEOUT_NUM=`sed -n "/${AGO_TIME}/,/${CUR_TIME}/p" content_soccer_players.${LOG_TIME} |awk -F'\t' '/REC/{if($9>0.5) print $9}' | wc -l`
      [ $TIMEOUT_NUM -gt 50 ] && wxalarm content_soccer_players ${TIMEOUT_NUM}
      echo $TIMEOUT_NUM
      ;;
    content_soccer_teams)
      TIMEOUT_NUM=`sed -n "/${AGO_TIME}/,/${CUR_TIME}/p" content_soccer_teams.${LOG_TIME} |awk -F'\t' '/REC/{if($9>0.5) print $9}' | wc -l`
      [ $TIMEOUT_NUM -gt 5 ] && wxalarm content_soccer_teams ${TIMEOUT_NUM}
      echo $TIMEOUT_NUM
      ;;
    content_TravelPOI)
      TIMEOUT_NUM=`sed -n "/${AGO_TIME}/,/${CUR_TIME}/p" content_TravelPOI.${LOG_TIME} |awk -F'\t' '/REC/{if($9>0.5) print $9}' | wc -l`
      [ $TIMEOUT_NUM -gt 5 ] && wxalarm content_TravelPOI ${TIMEOUT_NUM}
      echo $TIMEOUT_NUM
      ;;
    content_TravelLocation)
      TIMEOUT_NUM=`sed -n "/${AGO_TIME}/,/${CUR_TIME}/p" content_TravelLocation.${LOG_TIME} |awk -F'\t' '/REC/{if($9>0.5) print $9}' | wc -l`
      [ $TIMEOUT_NUM -gt 5 ] && wxalarm content_TravelLocation ${TIMEOUT_NUM}
      echo $TIMEOUT_NUM
      ;;
    content_videoname)
      TIMEOUT_NUM=`sed -n "/${AGO_TIME}/,/${CUR_TIME}/p" content_videoname.${LOG_TIME} |awk -F'\t' '/REC/{if($9>0.5) print $9}' | wc -l`
      [ $TIMEOUT_NUM -gt 50 ] && wxalarm content_videoname ${TIMEOUT_NUM}
      echo $TIMEOUT_NUM
      ;;
    content_FlightNum)
      TIMEOUT_NUM=`sed -n "/${AGO_TIME}/,/${CUR_TIME}/p" content_FlightNum.${LOG_TIME} |awk -F'\t' '/REC/{if($9>0.5) print $9}' | wc -l`
      [ $TIMEOUT_NUM -gt 10 ] && wxalarm content_FlightNum ${TIMEOUT_NUM}
      echo $TIMEOUT_NUM
      ;;
    content_News)
      TIMEOUT_NUM=`sed -n "/${AGO_TIME}/,/${CUR_TIME}/p" content_News.${LOG_TIME} |awk -F'\t' '/REC/{if($9>0.5) print $9}' | wc -l`
      [ $TIMEOUT_NUM -gt 10 ] && wxalarm content_News ${TIMEOUT_NUM}
      echo $TIMEOUT_NUM
      ;;
    content_book)
      TIMEOUT_NUM=`sed -n "/${AGO_TIME}/,/${CUR_TIME}/p" content_book.${LOG_TIME} |awk -F'\t' '/REC/{if($9>0.5) print $9}' | wc -l`
      [ $TIMEOUT_NUM -gt 10 ] && wxalarm content_book ${TIMEOUT_NUM}
      echo $TIMEOUT_NUM
      ;;
    content_shopping)
      TIMEOUT_NUM=`sed -n "/${AGO_TIME}/,/${CUR_TIME}/p" content_shopping.${LOG_TIME} |awk -F'\t' '/REC/{if($9>0.5) print $9}' | wc -l`
      [ $TIMEOUT_NUM -gt 10 ] && wxalarm content_shopping ${TIMEOUT_NUM}
      echo $TIMEOUT_NUM
      ;;
    content_people)
      TIMEOUT_NUM=`sed -n "/${AGO_TIME}/,/${CUR_TIME}/p" content_people.${LOG_TIME} |awk -F'\t' '/REC/{if($9>0.5) print $9}' | wc -l`
      [ $TIMEOUT_NUM -gt 100 ] && wxalarm content_people ${TIMEOUT_NUM}
      echo $TIMEOUT_NUM
      ;;
    *)
      echo 0
    esac
}

content_bot $1

# for botname in ${BOTNAMES[@]};do
#  content_bot $botname
# done
