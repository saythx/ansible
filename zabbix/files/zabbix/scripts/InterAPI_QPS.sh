#!/bin/bash
# nginx log process

# LOG_DIR=/home/trio/Nginx/logs/access.log
# STAT_TIME=$(date -d "1 minutes ago" +"%d/%b/%Y:%H:%M:")
# BJ_IDC='123.58.20.69:80'
#
# grep "${STAT_TIME}" ${LOG_DIR} > /tmp/nginxaccess.log && grep "${BJ_IDC}" /tmp/nginxaccess.log > /tmp/bjidc.log && grep -v "${BJ_IDC}" /tmp/nginxaccess.log > /tmp/aliyun.log

function QpsDisplay {
  case $1 in
    a_qps)
        A_QPS=$(awk '{if($7=="/nlp"){coun[$7]+=1} else if($7=="/nlp/resource"){coun[$7]+=1} else if($7=="/nlp/segmentation"){coun[$7]+=1}}END{for(i in coun) tot+=coun[i];print tot/60}' /tmp/aliyun.log)
        echo ${A_QPS}
        exit 0
        ;;
    b_qps)
        B_QPS=$(awk '{if($7=="/nlp"){coun[$7]+=1} else if($7=="/nlp/resource"){coun[$7]+=1} else if($7=="/nlp/segmentation"){coun[$7]+=1}}END{for(i in coun) tot+=coun[i];print tot/60}' /tmp/bjidc.log)
        echo ${B_QPS}
        exit 0
        ;;
    t_qps)
        B_QPS=$(awk '{if($7=="/nlp"){coun[$7]+=1} else if($7=="/nlp/resource"){coun[$7]+=1} else if($7=="/nlp/segmentation"){coun[$7]+=1}}END{for(i in coun) tot+=coun[i];print tot/60}' /tmp/bjidc.log)
        A_QPS=$(awk '{if($7=="/nlp"){coun[$7]+=1} else if($7=="/nlp/resource"){coun[$7]+=1} else if($7=="/nlp/segmentation"){coun[$7]+=1}}END{for(i in coun) tot+=coun[i];print tot/60}' /tmp/aliyun.log)
        T_QPS=$(echo "${A_QPS}+${B_QPS}"|bc)
        echo ${T_QPS}
        exit 0
        ;;
    a_nlp_qps)
        A_NLP_QPS=$(awk '{if($7=="/nlp"){coun[$7]+=1}}END{for(i in coun) print coun[i]/60}' /tmp/aliyun.log)
        echo ${A_NLP_QPS}
        exit 0
        ;;
    b_nlp_qps)
        B_NLP_QPS=$(awk '{if($7=="/nlp"){coun[$7]+=1}}END{for(i in coun) print coun[i]/60}' /tmp/bjidc.log)
        echo ${B_NLP_QPS}
        exit 0
        ;;
    t_nlp_qps)
        B_NLP_QPS=$(awk '{if($7=="/nlp"){coun[$7]+=1}}END{for(i in coun) print coun[i]/60}' /tmp/bjidc.log)
        A_NLP_QPS=$(awk '{if($7=="/nlp"){coun[$7]+=1}}END{for(i in coun) print coun[i]/60}' /tmp/aliyun.log)
        T_NLP_QPS=$(echo ${A_NLP_QPS}+${B_NLP_QPS}|bc)
        echo ${T_NLP_QPS}
        exit 0
        ;;
    a_seg_qps)
        A_SEG_QPS=$(awk '{if($7=="/nlp/segmentation"){coun[$7]+=1}}END{for(i in coun) print coun[i]/60}' /tmp/aliyun.log)
        echo ${A_SEG_QPS}
        exit 0
        ;;
    b_seg_qps)
        B_SEG_QPS=$(awk '{if($7=="/nlp/segmentation"){coun[$7]+=1}}END{for(i in coun) print coun[i]/60}' /tmp/bjidc.log)
        echo ${B_SEG_QPS}
        exit 0
        ;;
    t_seg_qps)
        A_SEG_QPS=$(awk '{if($7=="/nlp/segmentation"){coun[$7]+=1}}END{for(i in coun) print coun[i]/60}' /tmp/aliyun.log)
        B_SEG_QPS=$(awk '{if($7=="/nlp/segmentation"){coun[$7]+=1}}END{for(i in coun) print coun[i]/60}' /tmp/bjidc.log)
        T_SEG_QPS=$(echo ${A_SEG_QPS}+${B_SEG_QPS}|bc)
        echo ${T_SEG_QPS}
        exit 0
        ;;
    a_res_qps)
        A_RES_QPS=$(awk '{if($7=="/nlp/resource"){coun[$7]+=1}}END{for(i in coun) print coun[i]/60}' /tmp/aliyun.log)
        echo ${A_RES_QPS}
        exit 0
        ;;
    b_res_qps)
        B_RES_QPS=$(awk '{if($7=="/nlp/resource"){coun[$7]+=1}}END{for(i in coun) print coun[i]/60}' /tmp/bjidc.log)
        echo ${B_RES_QPS}
        exit 0
        ;;
    t_res_qps)
        A_RES_QPS=$(awk '{if($7=="/nlp/resource"){coun[$7]+=1}}END{for(i in coun) print coun[i]/60}' /tmp/aliyun.log)
        B_RES_QPS=$(awk '{if($7=="/nlp/resource"){coun[$7]+=1}}END{for(i in coun) print coun[i]/60}' /tmp/bjidc.log)
        T_RES_QPS=$(echo ${A_RES_QPS}+${B_RES_QPS}|bc)
        echo ${T_RES_QPS}
        exit 0
        ;;
    *)
        echo 'error args'
        exit 1;
        ;;
  esac
}

QpsDisplay $1
