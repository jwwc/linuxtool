# 安装java

java_tar_path="/root/java"
java_install_path="/root/java/"

zookeeper_tar_path="/root/zookeeper"
zookeeper_install_path="/opt/"
read -p "请输入需要批量执行指定的主机域名，使用空格分开， eg: jwwb jwwc    " hosts
#echo $hosts
hosts=(${hosts// / })

for host in ${hosts[@]}
do 
	echo $host
done

tmp_path="/root"

# java安装
for host in ${hosts[@]}
do
echo $java_tar_path 
source_filename=`ssh $host cd $tmp_path | ls | grep .tar.gz`
echo $java_tar_path/$source_filename
echo $host
ssh $host tar -xvf $java_tar_path/$source_filename  -C $java_install_path 
done

# zookeeper安装
for host in ${hosts[@]}
do
echo $zookeeper_tar_path
source_filename=`ssh $host cd $tmp_path | ls | grep .tar.gz`
echo $zookeeper_tar_path/$source_filename
echo $host
ssh $host tar -xvf $zookeeper_tar_path/$source_filename -C $zookeeper_install_path

done


