#!/bin/bash

set -e
echo "此脚本只支持一次执行成功，如果失败请分析脚本内容处理"
sleep 3
read -p "输入rocketchat包所在的主机(默认172.19.6.160):" remoteHost
read -p "输入rocketchat包路径(默认/opt/)" remotePath
read -p "输入rocketchat包文件(默认：sunchat.tar.gz)" remoteFile
read -p "请输入项目名，即部署环境的包名，（列如：rocketchatv1.5）:" package
remoteHost="${remoteHost:-172.19.6.160}"
remotePath="${remotePath:-/opt/}"
remoteFile="${remoteFile:-sunchat.tar.gz}"
filePath=${remotePath}${remoteFile}
path="/opt/"
file="sunchat.tar.gz"
package=${package:-rocketchatv1.5}
slaveHost="172.16.40.25"
#echo $remoteHost ${remotePath}${remoteFile}
#exit
if test -e ${filePath}
then
	echo "删除本地旧的部署包"
	rm -f ${filePath}
fi
echo "开始从测试环境复制部署包"
scp root@${remoteHost}:${filePath} ${path}
if [ $? -eq 0 ]
then
	echo "开始解压部署包"
	/bin/tar -zxf ${file}
fi
echo "npm安装包依赖。。"
cd bundle/programs/server/ && npm install && cd -
if [ -e ${package} ]
then
        echo "按时间结尾打包备份项目文件，后删除项目文件"
	tar zcf ${package}.$(date +%Y%m%d%H%m).tar.gz ${package} && rm -rf ${package}
	echo "备份完成"
fi
mv bundle ${package}
echo "重启应用。。。"
systemctl restart ${package}
sleep 5
if [ $(ps -ef | grep ${package} | wc -l) -gt 1 ]
then 
	echo "$HOSTNAME 部署完成。。。"
else
	echo "尝试重启。。。"
	systemctl restart ${package}
fi
#开始部署其它节点
echo "开始同步部署其它节点，暂时只有25"
slavePackage="${package}.$(date +%Y%m%d%H%m).slave.tar.gz"
echo "打包当前节点已安装依赖的新项目包"
tar zcf ${slavePackage} ${package}
echo "传输包到备节点"
scp ${slavePackage} ${slaveHost}:${path}
ssh ${slaveHost} "cd ${path} && rm -rf ${package}"
ssh ${slaveHost} "cd ${path} && tar zxf ${slavePackage}"
ssh ${slaveHost} "systemctl restart ${package}"
sleep 5
if test $(ssh ${slaveHost} "ps -ef | grep ${package} | wc -l") -gt 1
then 
   echo "slave 部署完成"
else
	echo "尝试重启slave节点"
	ssh ${slaveHost} "systemctl restart ${package}"
fi
