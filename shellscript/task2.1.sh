#!/usr/bin/env bash

# wget -O worldcupplayerinfo.tsv https://raw.githubusercontent.com/c4pr1c3/LinuxSysAdmin/master/exp/chap0x04/worldcupplayerinfo.tsv;

#帮助文档
file="worldcupplayerinfo.tsv"
function Help {
   echo "======= Help Document ======="
   echo "-a,--age                统计不同年龄区间范围(20岁以下、[20-30]、30岁以上)的球员数量、百分比"
   echo "-p,--position           统计不同场上位置的球员数量、百分比"
   echo "-ns,--name_search       查询名字最长的球员是谁？名字最短的球员是谁？"
   echo "-as,--age_search        查询年龄最大的球员是谁？年龄最小的球员是谁？"
   echo "-h,--help               显示本脚本的帮助文档"
}

#统计不同年龄区间范围(20岁以下、[20-30]、30岁以上)的球员数量、百分比
function count_age {
    awk -F '\t' '     #指定文件分隔符
    BEGIN {a=0;b=0;c=0;}
    $6!="Age" {
            if($6<20) 
                a++
            else if($6<=30) 
                b++
            else 
                c++
        }
        END {
            total=a+b+c;
            printf("Age\tNumber\tPercentage\n");
            printf("<20\t%d\t%f%%\n",a,a*100/total);
            printf("[20,30]\t%d\t%f%%\n",b,b*100/total);
            printf(">30\t%d\t%f%%\n",c,c*100/total);
        }' "$file"
        return
}

#统计不同场上位置的球员数量、百分比
function count_position {
    awk -F '\t' '
    BEGIN {a=0;b=0;c=0;d=0;total=-1;}
     {
            total++;
            if($5=="Goalie"){a++;}
            else if($5=="Defender"){b++;}
            else if($5=="Midfielder"){c++;}
            else{d++}
        }
        END {
                printf("Location\tNumber\tPercentage\n");
                printf("Goalie\t\t%d\t%f%%\n",a,a*100/total);
                printf("Defender\t%d\t%f%%\n",b,b*100/total);
                printf("Midfielder\t%d\t%f%%\n",c,c*100/total);
                printf("Forward\t\t%d\t%f%%\n",d,d*100/total);
        }' "$file"
        return
}

#名字最长的球员是谁？名字最短的球员是谁？
function name_search {
    awk -F "\t" '
        BEGIN {mx=-1;mi=1000;}
        {
            len=length($9);
            names[$9]=len;
            mx=len>mx?len:mx;
            mi=len<mi?len:mi;
        }
        END {
            for(i in names) {
                if(names[i]==mx){
                printf("The longest is %s\n", i);
                } else if(names[i]==mi) {
                    printf("The shortest is %s\n", i);
                }
            }
        }' "$file"
        return
}

#年龄最大的球员是谁？年龄最小的球员是谁？
function age_search {
    awk -F "\t" '
        BEGIN {mx=-1; mi=1000}
        NR>1 {
            age=$6;
            names[$9]=age;
            mx=age>mx?age:mx;
            mi=age<mi?age:mi;
        }
        END {
            printf("The eldest age is %d, is\n", mx);
            for(i in names) {
                if(names[i]==mx){
                    printf("%s\n", i);
                }
            }
            printf("The youngest age is %d, is\n",mi);
            for(i in names){
                if(names[i]==mi){
                    printf("%s\n", i);
                }
            }
            
        }' "$file"
        return
}

while true
do
  case "$1" in
       "-a")
       count_age
       exit 0
       ;;
       "-p")
       count_position
       exit 0
       ;;
       "-ns")
       name_search
       exit 0
       ;;
       "-ag")
       age_search
       exit 0
       ;;
       "-h")
        Help
        exit 0
        ;;
    esac
done