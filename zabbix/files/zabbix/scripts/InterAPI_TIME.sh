#!/bin/bash
# nginx log process

# LOG_DIR=/home/trio/Nginx/logs/access.log
# STAT_TIME=$(date -d "1 minutes ago" +"%d/%b/%Y:%H:%M:")
# BJ_IDC='123.58.20.69:80'
#
# grep "${STAT_TIME}" ${LOG_DIR} > /tmp/nginxaccesss.log && grep "${BJ_IDC}" /tmp/nginxaccesss.log > /tmp/bjidc.log && grep -v "${BJ_IDC}" /tmp/nginxaccesss.log > /tmp/aliyun.log

function TIMEDisplay {
  case $1 in
    a_time)
        COU_NUM=$(awk '{if($7=="/nlp") print $(NF-1) ;else if($7=="/nlp/resource") print $(NF-1); else if($7=="/nlp/segmentation") print $(NF-1)}' /tmp/aliyun.log | wc -l)
        NINEFIV=$(echo "${COU_NUM}*0.95" | bc | awk '{print int($0)+1}')
        A_TIME=$(awk '{if($7=="/nlp") print $(NF-1) ;else if($7=="/nlp/resource") print $(NF-1); else if($7=="/nlp/segmentation") print $(NF-1)}' /tmp/aliyun.log | sort -n | sed -n "${NINEFIV}p")
        echo ${A_TIME}
        exit 0
        ;;
    b_time)
        COU_NUM=$(awk '{if($7=="/nlp") print $(NF-1) ;else if($7=="/nlp/resource") print $(NF-1); else if($7=="/nlp/segmentation") print $(NF-1)}' /tmp/bjidc.log | wc -l)
        NINEFIV=$(echo "${COU_NUM}*0.95" | bc | awk '{print int($0)+1}')
        B_TIME=$(awk '{if($7=="/nlp") print $(NF-1) ;else if($7=="/nlp/resource") print $(NF-1); else if($7=="/nlp/segmentation") print $(NF-1)}' /tmp/bjidc.log | sort -n | sed -n "${NINEFIV}p")
        echo ${B_TIME}
        exit 0
        ;;
    t_time)
        COU_NUM=$(awk '{if($7=="/nlp") print $(NF-1) ;else if($7=="/nlp/resource") print $(NF-1); else if($7=="/nlp/segmentation") print $(NF-1)}' /tmp/nginxaccess.log | wc -l)
        NINEFIV=$(echo "${COU_NUM}*0.95" | bc | awk '{print int($0)+1}')
        T_TIME=$(awk '{if($7=="/nlp") print $(NF-1) ;else if($7=="/nlp/resource") print $(NF-1); else if($7=="/nlp/segmentation") print $(NF-1)}' /tmp/nginxaccess.log | sort -n | sed -n "${NINEFIV}p")
        echo ${T_TIME}
        exit 0
        ;;
    a_nlp_time)
        COU_NUM=$(awk '{if($7=="/nlp") print $(NF-1)}' /tmp/aliyun.log | wc -l)
        NINEFIV=$(echo "${COU_NUM}*0.95" | bc | awk '{print int($0)+1}')
        A_NLP_TIME=$(awk '{if($7=="/nlp") print $(NF-1)}' /tmp/aliyun.log | sort -n | sed -n "${NINEFIV}p")
        echo ${A_NLP_TIME}
        exit 0
        ;;
    b_nlp_time)
        COU_NUM=$(awk '{if($7=="/nlp") print $(NF-1)}' /tmp/bjidc.log | wc -l)
        NINEFIV=$(echo "${COU_NUM}*0.95" | bc | awk '{print int($0)+1}')
        B_NLP_TIME=$(awk '{if($7=="/nlp") print $(NF-1)}' /tmp/bjidc.log | sort -n | sed -n "${NINEFIV}p")
        echo ${B_NLP_TIME}
        exit 0
        ;;
    t_nlp_time)
        COU_NUM=$(awk '{if($7=="/nlp") print $(NF-1)}' /tmp/nginxaccess.log | wc -l)
        NINEFIV=$(echo "${COU_NUM}*0.95" | bc | awk '{print int($0)+1}')
        T_NLP_TIME=$(awk '{if($7=="/nlp") print $(NF-1)}' /tmp/nginxaccess.log | sort -n | sed -n "${NINEFIV}p")
        echo ${T_NLP_TIME}
        exit 0
        ;;
    a_seg_time)
        COU_NUM=$(awk '{if($7=="/nlp/segmentation") print $(NF-1)}' /tmp/aliyun.log | wc -l)
        NINEFIV=$(echo "${COU_NUM}*0.95" | bc | awk '{print int($0)+1}')
        A_SEG_TIME=$(awk '{if($7=="/nlp/segmentation") print $(NF-1)}' /tmp/aliyun.log | sort -n | sed -n "${NINEFIV}p")
        echo ${A_SEG_TIME}
        exit 0
        ;;
    b_seg_time)
        COU_NUM=$(awk '{if($7=="/nlp/segmentation") print $(NF-1)}' /tmp/bjidc.log | wc -l)
        NINEFIV=$(echo "${COU_NUM}*0.95" | bc | awk '{print int($0)+1}')
        B_SEG_TIME=$(awk '{if($7=="/nlp/segmentation") print $(NF-1)}' /tmp/bjidc.log | sort -n | sed -n "${NINEFIV}p")
        echo ${B_SEG_TIME}
        exit 0
        ;;
    t_seg_time)
        COU_NUM=$(awk '{if($7=="/nlp/segmentation") print $(NF-1)}' /tmp/nginxaccess.log | wc -l)
        NINEFIV=$(echo "${COU_NUM}*0.95" | bc | awk '{print int($0)+1}')
        T_SEG_TIME=$(awk '{if($7=="/nlp/segmentation") print $(NF-1)}' /tmp/nginxaccess.log | sort -n | sed -n "${NINEFIV}p")
        echo ${T_SEG_TIME}
        exit 0
        ;;
    a_res_time)
        COU_NUM=$(awk '{if($7=="/nlp/resource") print $(NF-1)}' /tmp/aliyun.log | wc -l)
        NINEFIV=$(echo "${COU_NUM}*0.95" | bc | awk '{print int($0)+1}')
        A_RES_TIME=$(awk '{if($7=="/nlp/resource") print $(NF-1)}' /tmp/aliyun.log | sort -n | sed -n "${NINEFIV}p")
        echo ${A_RES_TIME}
        exit 0
        ;;
    b_res_time)
        COU_NUM=$(awk '{if($7=="/nlp/resource") print $(NF-1)}' /tmp/bjidc.log | wc -l)
        NINEFIV=$(echo "${COU_NUM}*0.95" | bc | awk '{print int($0)+1}')
        B_RES_TIME=$(awk '{if($7=="/nlp/resource") print $(NF-1)}' /tmp/bjidc.log | sort -n | sed -n "${NINEFIV}p")
        echo ${B_RES_TIME}
        exit 0
        ;;
    t_res_time)
        COU_NUM=$(awk '{if($7=="/nlp/resource") print $(NF-1)}' /tmp/nginxaccess.log | wc -l)
        NINEFIV=$(echo "${COU_NUM}*0.95" | bc | awk '{print int($0)+1}')
        T_RES_TIME=$(awk '{if($7=="/nlp/resource") print $(NF-1)}' /tmp/nginxaccess.log | sort -n | sed -n "${NINEFIV}p")
        echo ${T_RES_TIME}
        exit 0
        ;;
    *)
        echo 'error args'
        exit 1;
        ;;
  esac
}

TIMEDisplay $1
