#!/usr/bin/env bash

# 帮助文档
function Help {
    echo "======== Help Document ========"
    echo "-q             对jpeg格式图片进行图片质量压缩"
    echo "-r             对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩成R分辨率"
    echo "-w             对图片批量添加自定义文本水印"
    echo "-p             统一添加文件名前缀"
    echo "-s             统一添加文件名后缀"
    echo "-c             将png/svg图片统一转换为jpg格式图片"
    echo "-h             显示本脚本的帮助手册"
}

# 对jpeg格式图片进行图片质量压缩
function quality_compress {
    for img in *.jepg  #将jpeg格式图片循环出来
    do
    [[ -e "$img" ]] || break
    jpegoptim -d ./compressed -p "$img" #将压缩的图片保存在./compressed目录并拥有与原图片同样的修改时间
    done
}

# 对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩成R分辨率
function resolution_compress {
    for img in *.jepg *.png *.svg 
    do
    [[ -e "$img" ]] || break
    convert "$img" -resize 50% "$img" "$2" #将原图压缩50%，convert可以控制图片的宽和高
    echo "$img has been resized to $2"
    done 
}

# 对图片批量添加自定义文本水印
function add_watermark {
    for img in *.jepg
    do
    [[ -e "$img" ]] || break
    convert -font Arial -fill white -pointsize 36 -draw 'text 10,50 "this is a watermark"' "$img" "$2" #font指定字体类型 fill指定颜色 pointsize以点为单位指定字母大小 draw添加自定义文本
    echo "$img has been watermarked to $2" 
    done
}

# 支持批量重命名（统一添加文件名前缀或后缀，不影响原始文件扩展名）
function add_prefix {
    for i in *
    do
    [[ -e "$i" ]] || break
    mv "$i" "prefix"$i
    echo "$i is prefixed"
    done
}

function add_suffix {
    for i in *
    do
    [[ -e "$i" ]] || break
    mv "$i" $i"suffix"
    echo "$i is suffixed"
    done
}

# 支持将png/svg图片统一转换为jpg格式图片
function convert_jpg {
    for i in *.png *.svg
    do
    [[ -e "$i" ]] || break
    newpicture=${i%.*}".jpg"
    convert "$i" "${newpicture}"
    done
}


# 支持命令行参数方式使用不同功能
while true
do
case "$1" in
"-q")
      quality_compress "$2"
      exit 0
      ;;
"-r")
      resolution_compress "$2" "$3"
      exit 0
      ;;
"-w")
      add_watermark "$2" "$3"
      exit 0
      ;;
"-p")
      add_prefix "$2"
      exit 0
      ;;
"-s")
      add_suffix "$2"
      exit 0
      ;;
"-c")
      convert_jpg "$2"
      exit 0
      ;;
"-h")
      Help
      exit 0
      ;;

esac
done