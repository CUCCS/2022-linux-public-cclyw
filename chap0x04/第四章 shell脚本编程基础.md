# 第四章 shell脚本编程基础

## 实验环境
* Ubuntu 20.04 VS remote
* imagemagick
* jepgoptim

## 实验目的
#### 任务一：用bash编写一个图片批处理脚本，实现以下功能：

 - [x] 支持命令行参数方式使用不同功能
 - [x] 支持对指定目录下所有支持格式的图片文件进行批处理
 - [x] 支持以下常见图片批处理功能的单独使用或组合使用
    - [x] 支持对jpeg格式图片进行图片质量压缩
    - [x] 支持对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率
    - [x] 支持对图片批量添加自定义文本水印
    - [x] 支持批量重命名（统一添加文件名前缀或后缀，不影响原始文件扩展名）
    - [x] 支持将png/svg图片统一转换为jpg格式图片

#### 任务二：用bash编写一个文本批处理脚本，对以下附件分别进行批量处理完成相应的数据统计任务：

 - [x] 统计不同年龄区间范围（20岁以下、[20-30]、30岁以上）的球员数量、百分比
 - [x] 统计不同场上位置的球员数量、百分比
 - [x] 名字最长的球员是谁？名字最短的球员是谁？
 - [x] 年龄最大的球员是谁？年龄最小的球员是谁？

#### 任务三：用bash编写一个文本批处理脚本，对以下附件分别进行批量处理完成相应的数据统计任务：

 - [x] 统计访问来源主机TOP 100和分别对应出现的总次数
 - [x] 统计访问来源主机TOP 100 IP和分别对应出现的总次数
 - [x] 统计最频繁被访问的URL TOP 100
 - [x] 统计不同响应状态码的出现次数和对应百分比
 - [x] 分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数
 - [x] 给定URL输出TOP 100访问来源主机

## 实验步骤

#### 任务1
1. 按照老师的教课视频，配置好vs remote环境便于shell脚本编写，同时安装并熟悉```shellcheck```
2.  ```sudo apt install imagemagick```
   输入命令，提前安装好```imagemagick```用于图片处理操作
3. 编写shell脚本
   ![script1](./img/script.png)
4. 输出结果

#### 任务2.1
1. 下载老师提供的2014世界杯运动员数据tsv文件，并用scp传输到虚拟机

2. 根据要求编写脚本
![script2.1](./img/script2.1.png)

3. 输出结果

#### 任务2.2
1. 下载老师提供的web_log.tsv文件，并借助scp传输到虚拟机
2.  编写shell脚本
![script2.2](./img/script2.2.png)
3. 运行脚本 

#### Travis
参考老师视频教程，完成travis.yml的编写

## 实验问题及方法总结
1. awk等很多命令语法不熟悉，上网参考了很多教程
2. convert命令功能强大，支持JPG, BMP, PCX, GIF, PNG, TIFF, XPM和XWD等类型；而jpegoptim用于优化/压缩jpeg文件。想要实现两个命令功能都必须先sudo apt install
3. shell脚本语言编写在vs上进行，写错可以进行bug排查并修正

## 参考文献
* [awk官方文档](https://www.gnu.org/software/gawk/manual/html_node/History.html#History)
* [jpegoptim使用教程](https://www.cnblogs.com/love-snow/articles/8252644.html)
* [imageMagic实战](https://blog.csdn.net/dongfang1984/article/details/84798174)
* [travis CI教程](https://www.ruanyifeng.com/blog/2017/12/travis_ci_tutorial.html)
* [2021-linux-public-caomoumou-github](https://github.com/padresvater/shell-examples/blob/master/data_processing2.sh)

