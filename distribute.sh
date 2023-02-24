#!/bin/bash

#echo "输入分发的主机个数"
#echo "eg 2"

#hostsnum=$1
read -p "输入分发的主机个数, eg:2    " hostnum
echo $hostnum
if ((hostnum<0)); then
	echo "分发的主机数不能小于0"
	exit;
fi
#echo "输入分发主机的内网域名"
#echo "eg jwwb jwwc"

read -p "输入分发主机的内网域名,以空格隔开, eg jwwa jwwb   " hosts
hosts=(${hosts// / })
#echo $hosts
#定义分发的主机域名列表
#hosts=()

#当前用户名
user='root'


for host in ${hosts[@]}
do
	echo $host
done

#echo "输入分发的文件路径"
#echo "eg: /root/test"
read -p "输入分发的文件路径, eg: /root/test    " file
echo $file
#filename=$1

#echo "输入分发的主机的目标路径"
#echo "eg: /root/recv"
read -p "输入分发的主机的目标路径, eg: /root/recv    " pdir
echo $pdir
#pdir=$1
#需要分发的文件的绝对路径
#files=()
# for file in "$@"
#do
#	files[${#files[@]}]=$file
#done

# 分发文件
for hostname in ${hosts[@]}
do
	rsync -rvl $file $user@$hostname:$pdir
done
