#!/usr/bin/env bash

#帮助文档

function Help {
    echo "==============Help Document=============="
    echo "
        
    -h,--help                  显示本脚本的帮助文档
    -ho,--host                 统计访问来源主机TOP 100和分别对应出现的总次数   
    -i,--ip                    统计访问来源主机TOP 100 IP和分别对应出现的总次数
    -u,--url                   统计最频繁被访问的URL TOP 100
    -c,--condition             统计不同响应状态码的出现次数和对应百分比
    -4,--4xx                   分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数 
    -uh,--url_host             给定URL输出TOP 100访问来源主机"
}

#统计访问来源主机TOP 100和分别对应出现的总次数
function host_top100 {
     awk -F "\t" '
    NR>1 {host[$1]++;}
    END {
        printf ("%40s\t%s\n","TOP_host","num");
        for(i in host) 
        {
            printf("%40s\t%d\n",i,host[i]);
        } 
    }
    ' web_log.tsv | sort -g -k 2 -r | head -100
}

#统计访问来源主机TOP 100 IP和分别对应出现的总次数
function host_top100ip {
    awk -F "\t" '
    NR>1{
        if($1~/([0-9]{1,3}\.){3}[0-9]{1,3}/){
            ip[$1]++; 
        }
    }
    END{
        printf("%20s\t%s\n","TOP_IP","num");
        for(i in ip){
            printf("%20s\t%d\n",i,ip[i]);
        } 
    }
    ' web_log.tsv | sort -g -k 2 -r | head -100
}

# 统计最频繁被访问的URL TOP 100
function top100_url {
    awk -F "\t" '
    NR>1 {
        url[$5]++;
    }
    END {
        printf("%60s\t%s\n","TOP_URL","num");
        for(i in url) {
            printf("%60s\t%d\n",i,url[i]);
            } 
    }
    ' web_log.tsv | sort -g -k 2 -r | head -100    
}

# 统计不同响应状态码的出现次数和对应百分比
function code_condition {
    awk -F "\t" '
    NR>1 {
        s_code[$6]++;
    }
    END { 
        for(i in s_code) 
        {
            printf("%d\t%d\t%f%%\n",i,s_code[i],100.0*s_code[i]/(NR-1));
        } 
    }
    ' web_log.tsv
}

# 分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数
function code_condition_4XX {
    awk -F "\t" '
    NR>1 { 
        if($6=="403") s_code[$5]++;
    }
    END { 
        printf("%60s\t%s\n","code=403_URL","num");
        for(i in s_code) 
        {
            printf("%60s\t%d\n",i,s_code[i]);
        } 
    }
    ' web_log.tsv | sort -g -k 2 -r | head -10
    awk -F "\t" '
    NR>1 { 
        if($6=="404") s_code[$5]++;
    }
    END { 
        printf("%60s\t%s\n","code=404_URL","num");
        for(i in s_code) {
            printf("%60s\t%d\n",i,s_code[i]);
        } 
    }
    ' web_log.tsv | sort -g -k 2 -r | head -10
}

# 给定URL输出TOP 100访问来源主机
function url_host {
    awk -F '\t' '
    NR>1 {
        if("'"$1"'"==$5) 
        {
            host[$1]++;
        }
    }
    END { 
        printf("%50s\t%s\n","TOP100_host","num");
        for(i in host) 
        {
            printf("%50s\t%d\n",i,host[i]);
            } 
    }
    ' web_log.tsv | sort -g -k 2 -r | head -100
}

# main函数
while true
do
    case "$1" in
        -ho)
            host_top100
            exit 0
            ;;
        -i)
            host_top100ip
            exit 0
            ;;
        -u)
            top100_url
            exit 0
            ;;
        -c)
            code_condition
            exit 0
            ;; 
        -4)
            code_condition_4XX
            exit 0
            ;;
        -uh)
            url_host "$2"
            exit 0
            ;;
        -h)
            Help
            exit 0
            ;;
    esac
done