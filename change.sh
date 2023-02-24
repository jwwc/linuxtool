# 可供选择的安装的软件种类

echo "1:java, 2:kafka, 3:zookeeper, 4:nginx"
read -p "请输入你需要安装的软件类型 " kind
case $kind in
	1)  cp /root/contentBroadcast/Install.sh /root/java/
	    cd /root/java/
	    bash Install.sh
	    rm -rf Install.sh
	;;
	2)  cp /root/contentBroadcast/Install.sh /root/kafka/
	    cd /root/kafka/
            bash Install.sh
	    rm -rf Install.sh
	;;
	3)  cp /root/contentBroadcast/Install.sh /root/zookeeper/
	    cd /root/zookeeper/
	    bash Install.sh
	    rm -rf Install.sh
	;;  
	4)  cp /root/contentBroadcast/Install.sh /root/nginx/
	    cd /root/nginx/
	    bash Install.sh
	    rm -rf Install.sh
	;;
esac 
