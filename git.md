# git的用法以及遇到的问题

## 新建一个远程仓库之后，第一次提交报错：error: The requested URL returned error: 403 Forbidden while accessing https://github.com/jwwc/linuxtool.git/info/refs
 	- 当前环境
		- 远程仓库是空库
        	- 执行过的指定有
			- git init
			- git add xxx
			- git commit -m "xxx"
	        	- git git branch -M main
			- git remote add origin https://github.com/xxx/xxx.git
       - 问题原因 
		- git版本过低
       - 解决办法：升级版本
		- yum remove git
		- wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.22.0.tar.gz
		- tar zxvf git-2.22.0.tar.gz
		- cd git-2.22.0
		- ./configure
		- make && make install
		- 遇到的问题：-bash: /usr/bin/git: No such file or directory
		- 解决的办法：找到生成的git指令集，创建软连接
		- ln -s /usr/local/bin/* /usr/local/bin/
		- git push 提交遇到的问题：现在github不在支持账号密码登陆，改用token登陆
		- token生成的参考连接[github token生成](https://blog.csdn.net/Forbest1/article/details/127937452)
		- 缓存token:
				- git config --global credential.helper cache
				- git config --global credential.helper 'cache --timeout=3600'
		- 设置push分支
				- git push --set-upstream origin main
				 
