# 第三章 Linux服务器系统管理基础

------

# Systemd入门教程跟练

------

## 实验环境
- **ubuntu 20.04**

------

## 实验操作录屏

### 命令篇
### 一、系统管理
- **1.1 systemd-analyze 查看启动耗时**
  [![asciicast](https://asciinema.org/a/IKBL4Izzac1AzkrksOMD8RAWq.svg)](https://asciinema.org/a/IKBL4Izzac1AzkrksOMD8RAWq)

- **1.2 hostnamectl 主机信息**
  [![asciicast](https://asciinema.org/a/2w3fpnv3eQxT5cyvke82TqE9A.svg)](https://asciinema.org/a/2w3fpnv3eQxT5cyvke82TqE9A)

- **1.3 localectl 本地化设置**
  [![asciicast](https://asciinema.org/a/1IZO34LNjyvNEuIrI0dMdwDqT.svg)](https://asciinema.org/a/1IZO34LNjyvNEuIrI0dMdwDqT)

- **1.4 timedatectl 时区设置**
[![asciicast](https://asciinema.org/a/8sSTDCgwd70PVCexcZYI8sOPY.svg)](https://asciinema.org/a/8sSTDCgwd70PVCexcZYI8sOPY)

- **1.5 loginctl 登录用户**
  [![asciicast](https://asciinema.org/a/C53VGzn3LS4dH0L0LenS7YtLP.svg)](https://asciinema.org/a/C53VGzn3LS4dH0L0LenS7YtLP)


### 二、Unit
- **2.1 systemctl list-units命令可以查看当前系统的所有 Unit**
[![asciicast](https://asciinema.org/a/M7Wm2rI0yLJdaaXgiWnh0wrY7.svg)](https://asciinema.org/a/M7Wm2rI0yLJdaaXgiWnh0wrY7)

- **2.2 Unit 的状态**
[![asciicast](https://asciinema.org/a/AjoYfSyW6ViatmrQjkvRRJpmQ.svg)](https://asciinema.org/a/AjoYfSyW6ViatmrQjkvRRJpmQ)

- **2.3 Unit 管理**
#### 对于用户来说，最常用的是下面这些命令，用于启动和停止 Unit（主要是 service）
  [![asciicast](https://asciinema.org/a/AxbM9aW9IdDJj3LvnRFLTIPRk.svg)](https://asciinema.org/a/AxbM9aW9IdDJj3LvnRFLTIPRk)

- **2.4 依赖关系**
[![asciicast](https://asciinema.org/a/UOfGfAb55uLfpdToTqQVfYus8.svg)](https://asciinema.org/a/UOfGfAb55uLfpdToTqQVfYus8)

### 三、Unit 的配置文件
[![asciicast](https://asciinema.org/a/cMmXxl1lpWQYbrVK8tD0Hng7j.svg)](https://asciinema.org/a/cMmXxl1lpWQYbrVK8tD0Hng7j)

### 四、Target
[![asciicast](https://asciinema.org/a/MyfG0SCLRBgjdNyYVS42j81WM.svg)](https://asciinema.org/a/MyfG0SCLRBgjdNyYVS42j81WM)

### 五、日志管理
[![asciicast](https://asciinema.org/a/I4E5OILM5kzhTtGB20kQacIC3.svg)](https://asciinema.org/a/I4E5OILM5kzhTtGB20kQacIC3)

### 实战篇
[![asciicast](https://asciinema.org/a/J1ioS0xo6DROJgfUrMNUotq64.svg)](https://asciinema.org/a/J1ioS0xo6DROJgfUrMNUotq64)

------

# 自查清单

- **如何添加一个用户并使其具备sudo执行程序的权限？**
```shell
sudo adduser username #添加用户
sudo usermod -G sudo username #添加sudo权限
```

- **如何将一个用户添加到一个用户组？**
```shell
sudo adduser username groupname
```
  
- **如何查看当前系统的分区表和文件系统详细信息？**
```shell
sudo fdisk -l #查看分区表
df -T #只可以查看已经挂载的分区和文件系统类型
lsblk -f  #也可以查看未挂载的文件系统类型
```

- **如何实现开机自动挂载Virtualbox的共享目录分区？**
```shell
（1）首先在virtualbox点击设置 -> 共享文件夹 -> 共享文件夹 创建一个名为share的文件夹
 (2) sudo mkdir /mnt/share #在虚拟机的/mnt目录下新建一个共享文件的挂载目录命名为share
 (3)进入/etc/fstab进行编辑
 share /mnt/share vboxsf rw,auto 0 0 #第一个参数share代表共享文件夹名称,第二个参数 /mnt/share代表Ubuntu中的挂载地址
```

- **基于LVM（逻辑分卷管理）的分区如何实现动态扩容和缩减容量？**
```shell
lvextend -L {{size}} #动态扩容
lvreduce -L {{size}} #缩减容量
```
- **如何通过systemd设置实现在网络连通时运行一个指定脚本，在网络断开时运行另一个脚本？**
```shell  
(1)修改systemd-networkd中的Service
(2)ExecStartPost=网络联通时运行的指定脚本
(3)ExecStopPost=网络断开时运行的另一个脚本
```

- **如何通过systemd设置实现一个脚本在任何情况下被杀死之后会立即重新启动？实现杀不死？**
```shell
sudo systemctl vi scriptname
Restart = always
sudo systemctl daemon-reload
```

------

# 参考文献
[第三章课件](https://c4pr1c3.github.io/LinuxSysAdmin/chap0x03.md.html#/systemd)

[Systemd 入门教程：命令篇 by 阮一峰的网络日志](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-commands.html)

[Systemd 入门教程：实战篇 by 阮一峰的网络日志](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-part-two.html)

[Linux下如何查看分区文件系统类型](https://blog.csdn.net/weixin_34019144/article/details/85628522?spm=1001.2101.3001.6650.1&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-1.pc_relevant_default&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-1.pc_relevant_default&utm_relevant_index=2)

[LVM详解](https://www.cnblogs.com/cloudos/p/9348315.html)