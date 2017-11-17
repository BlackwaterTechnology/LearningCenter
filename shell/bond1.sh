#/bin/bash
#bonding脚本
IP1=192.168.33.21
GATE1=192.168.33.1
IP2=192.168.33.22
GATE2=192.168.33.1
IP3=192.168.33.23
GATE3=192.168.33.1
IP4=192.168.33.24
GATE4=192.168.33.1

#
modprobe bonding

#查看网卡信息文件 若无则创建
[ ! -f /root/netinfo.txt ] && ifconfig -a |grep eno |awk -F ":" '{print $1}' >/root/netinfo.txt

ETH1=`cat /root/netinfo.txt|sed -n '1p'`
ETH2=`cat /root/netinfo.txt|sed -n '2p'`
ETH3=`cat /root/netinfo.txt|sed -n '3p'`
ETH4=`cat /root/netinfo.txt|sed -n '4p'`
ETH5=`cat /root/netinfo.txt|sed -n '5p'`
ETH6=`cat /root/netinfo.txt|sed -n '6p'`
ETH7=`cat /root/netinfo.txt|sed -n '7p'`
ETH8=`cat /root/netinfo.txt|sed -n '8p'`

#备份网卡配置文件
mkdir /etc/sysconfig/network-scripts/backup
cp /etc/sysconfig/network-scripts/ifcfg* /etc/sysconfig/network-scripts/backup/

#新建bond.conf文件  下面的内容要按实际需求修改
cat <<EOF> /etc/modprobe.d/bond.conf
alias bond0 bonding
alias bond1 bonding
alias bond2 bonding
alias bond3 bonding
options bond0 miimon=100 mode=1
EOF


#修改原有网卡配置文件
cat <<EOF> /etc/sysconfig/network-scripts/ifcfg-$ETH1
TYPE=Ethernet
BOOTPROTO=none
NAME=$ETH1
DEVICE=$ETH1
ONBOOT=yes
NM_CONTROLLED=no
USERCTL=no
MASTER=bond0
SLAVE=yes
EOF

cat <<EOF> /etc/sysconfig/network-scripts/ifcfg-$ETH2
TYPE=Ethernet
BOOTPROTO=none
NAME=$ETH2
DEVICE=$ETH2
ONBOOT=yes
NM_CONTROLLED=no
USERCTL=no
MASTER=bond0
SLAVE=yes
EOF

cat <<EOF> /etc/sysconfig/network-scripts/ifcfg-$ETH3
TYPE=Ethernet
BOOTPROTO=none
NAME=$ETH3
DEVICE=$ETH3
ONBOOT=yes
NM_CONTROLLED=no
USERCTL=no
MASTER=bond1
SLAVE=yes
EOF

cat <<EOF> /etc/sysconfig/network-scripts/ifcfg-$ETH4
TYPE=Ethernet
BOOTPROTO=none
NAME=$ETH4
DEVICE=$ETH4
ONBOOT=yes
NM_CONTROLLED=no
USERCTL=no
MASTER=bond1
SLAVE=yes
EOF

cat <<EOF> /etc/sysconfig/network-scripts/ifcfg-$ETH5
TYPE=Ethernet
BOOTPROTO=none
NAME=$ETH5
DEVICE=$ETH5
ONBOOT=yes
NM_CONTROLLED=no
USERCTL=no
MASTER=bond2
SLAVE=yes
EOF

cat <<EOF> /etc/sysconfig/network-scripts/ifcfg-$ETH6
TYPE=Ethernet
BOOTPROTO=none
NAME=$ETH6
DEVICE=$ETH6
ONBOOT=yes
NM_CONTROLLED=no
USERCTL=no
MASTER=bond2
SLAVE=yes
EOF

cat <<EOF> /etc/sysconfig/network-scripts/ifcfg-$ETH7
TYPE=Ethernet
BOOTPROTO=none
NAME=$ETH7
DEVICE=$ETH7
ONBOOT=yes
NM_CONTROLLED=no
USERCTL=no
MASTER=bond3
SLAVE=yes
EOF

cat <<EOF> /etc/sysconfig/network-scripts/ifcfg-$ETH8
TYPE=Ethernet
BOOTPROTO=none
NAME=$ETH8
DEVICE=$ETH8
ONBOOT=yes
NM_CONTROLLED=no
USERCTL=no
MASTER=bond3
SLAVE=yes
EOF

#创建bond网卡配置文件
#bond0 默认设置为主备配置如下
cat <<EOF> /etc/sysconfig/network-scripts/ifcfg-bond0
DEVICE=bond0
TYPE=Ethernet
ONBOOT=yes
BOOTPROTO=none
NM_CONTROLLED=no
USERCTL=no
BONDING_OPTS="mode=1"
IPADDR=$IP1
NETMASK=255.255.255.0
GATEWAY=$GATE1
EOF

#bond1 默认设置为主备配置如下
cat <<EOF> /etc/sysconfig/network-scripts/ifcfg-bond1
DEVICE=bond1
TYPE=Ethernet
ONBOOT=yes
BOOTPROTO=none
NM_CONTROLLED=no
USERCTL=no
BONDING_OPTS="mode=1"
IPADDR=$IP2
NETMASK=255.255.255.0
GATEWAY=$GATE2
EOF


#bond2 默认设置为负载均衡配置如下
cat <<EOF> /etc/sysconfig/network-scripts/ifcfg-bond2
DEVICE=bond2
TYPE=Ethernet
ONBOOT=yes
BOOTPROTO=none
NM_CONTROLLED=no
USERCTL=no
BONDING_OPTS="mode=4 miimon=100 ad_select=1 updelay=200 xmit_hash_policy=2"
IPADDR=$IP3
NETMASK=255.255.255.0
GATEWAY=$GATE3
EOF



#bond3 默认设置为负载均衡配置如下
cat <<EOF> /etc/sysconfig/network-scripts/ifcfg-bond3
DEVICE=bond3
TYPE=Ethernet
ONBOOT=yes
BOOTPROTO=none
NM_CONTROLLED=no
USERCTL=no
BONDING_OPTS="mode=4 miimon=100 ad_select=1 updelay=200 xmit_hash_policy=2"
IPADDR=$IP4
NETMASK=255.255.255.0
GATEWAY=$GATE4
EOF


#重启网卡
systemctl restart network

#附加 slave 接口到 bond0，bond1，bond2
echo "ifenslave bond0 $ETH1 $ETH2" >> /etc/rc.local
echo "ifenslave bond1 $ETH3 $ETH4" >> /etc/rc.local
echo "ifenslave bond2 $ETH5 $ETH6" >> /etc/rc.local
echo "ifenslave bond3 $ETH7 $ETH8" >> /etc/rc.local



