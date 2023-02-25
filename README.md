# 集群分发环境的代建


## scp的免密码传输
   - ssh-key生成密钥
   - yum install rsync 安装同步指令
   - bash distribute.sh 调用分发脚本，将生成的密钥分发密钥到其他服务器，密钥的分发是相互，可以使用ssh指令进行远程执行{ssh 远程IP '需要执行的指令'}，同时对密钥进行合并{cat authora_keys authorb_key > authorized_keys}
   - 配置内网域名的映射文件{ vim /etc/hosts ; Ip : 域名}
   - bash distribute.sh 调用分发脚本，将修改的映射文件同步到其他的服务器节点

## distribute.sh
   - 功能：批量同步服务器节点之间的文件
## Instanll.sh change.sh 
   - 功能：同步服务器之间的批量化指令执行
   - 未完善
## 安装java环境
   - wget https://download.oracle.com/java/19/latest/jdk-19_linux-x64_bin.tar.gz 下载安装包
   - bash distribute.sh 调用分发脚本，将安装包分发到其他的服务器节点
	- 注意，这里我们也可以配置好之后，再进行分发，但是解压之后的文件过大时，分发文件可能会比较耗时
   - tar jdk-19_linux-x64_bin.tar.gz -C /opt/ 解压到指定的目录
   - 配置配置文件
	- vim /etc/profile
	- 需要追加的内容
		- export JAVA_HOME=/root/java/jdk-19.0.2
		- export PATH=$PATH:${JAVA_HOME}/bin
## 安装zookeeper环境
   - wget https://mirrors.tuna.tsinghua.edu.cn/apache/zookeeper/zookeeper-3.8.1/apache-zookeeper-3.8.1-bin.tar.gz 下载安装包
   - bash distribute.sh 调用分发脚本，将安装包分发到其他的服务器节点
   - tar apache-zookeeper-3.8.1-bin.tar.gz -C /opt/ 解压到指定目录
   - 配置配置文件
	- cd /opt/apache-zookeeper-3.8.1-bin/conf
	- cp zoo_sample.cfg zoo.cfg
	- 配置文件示例
		- 需要追加的内容
		- quorumListenOnAllIPs=true
		- server.1=154.92.14.207:2888:3888
		- server.2=154.83.16.157:2888:3888
		- server.3=154.211.14.239:2888:3888
		- 需要修改的内容
		- dataDir=/root/zookeeper
	- 在dataDir的目录下增加配置文件 vim myid 内容为服务器节点的编号，为整形数字
   - bash distribute.sh 调用分发脚本，同步配置文件和myid文件
   - 通过ssh远程执行，修改每一个服务器节点的唯一性配置(例如：myid)
   - 测试
	- ./zkServer.sh start
	- ./zkServer.sh status
	- 如果选举成功，则表示zookeeper安装成功
## 安装kafka
   - wget https://downloads.apache.org/kafka/3.3.2/kafka_2.13-3.3.2.tgz
   - bash distribute.sh 调用分发脚本，将安装包分发到其他的服务器节点
   - tar kafka_2.13-3.3.2.tgz -C /opt/ 解压到指定目录
   - 配置配置文件
        - vim /opt/kafka_2.13-3.3.2/config/server.properties
        - 配置文件示例：server.properties
   - bash distribute.sh 调用分发脚本，分发配置文件
   - 通过ssh远程指令，修改服务器节点的唯一性配置
        - broker.id
        - listeners=PLAINTEXT://154.83.16.157:9092
   - ./kafka-server-start.sh -daemon ../config/server.properties 启动kafka
   - 遇到的文件
        - 创建主题：
                -  ./kafka-topics.sh --create --bootstrap-server 154.83.16.157:9092 --replication-factor 3 --partitions 2 --topic google
                -  WARN [AdminClient clientId=adminclient-1] Connection to node -1 (/154.83.16.157:9092) could not be established. Broker may not be available.
		- 解决办法:
			- 删除advertised.listeners=PLAINTEXT://154.83.16.157:9092
			- 但是还不知道原因

			   
