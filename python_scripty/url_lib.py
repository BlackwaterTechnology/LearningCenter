from urllib import request
from  urllib import parse
import json

#?sessionId=71cc31bcb1514a0ea51b18ab93a03acd&mobile=&nick=&userName=&userId=538949&email=@suneee.com&compId=1
#定义一个列表存放用户登陆提交的信息
body =  [("account","@suneee.com"),("password",""),("enterpriseCode","SUNEEE"),("appCode","XIANGPU"),('clientIp',"127.0.0.1"),('encryptCode',"1234567899876543")]
#将列表编码成字节码
DATA = parse.urlencode(body)

#定义请求体
req = request.Request(url='http://uc.weilian.cn/account_auth_admin/personal-api.loginPower', data=DATA.encode('utf-8'),method='POST')
#修改客户端的信息，避免服务器发现是python脚本访问
req.add_header("User-Agent","Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.101 Safari/537.36")
#发起请求
with request.urlopen(req) as f:
    #打印状态和结果
    print('Status:', f.status, f.reason)
    #遍历服务器返回的header信息
    # for k,v in f.getheaders():
    #     print('%s:%s' % (k, v))
    #读取返回内容并解码成utf8的字符串
    response = f.read().decode('utf-8')
    #将字符串转换成字典格式
    Response = json.loads(response)
    #返回状态
    status = Response["status"]
    #返回消息
    message = Response["message"]

sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list

curl http://127.0.0.1:8080/bpmx/
    #提取子公司信息列表
    enterprises = Response["data"]["dataPower"]#["enterprise"]["companyChildren"]
    提取用户信息
    user = Response["data"]["user"]
    user_enterpriseCode = user["enterpriseCode"]
    user_address = user["address"]
    #用户的sessionId,可以用于登陆授权
    user_sessionId = user["sessionId"]
    user_registerTime = user["registerTime"]
    user_signature = user["signature"]
    user_sex = user["sex"]
    user_mobile = user["mobile"]
    user_photo = user["photo"]
    user_appCode = user["appCode"]
    user_userName = user["userName"]
    user_userId = user["userId"]
    user_enabled = user["enabled"]
    user_password = user["password"]
    user_backgroundImg = user["backgroundImg"]
    user_name = user["name"]
    user_account = user["account"]
    user_lastUpdateTime = user["lastUpdateTime"]
    # userinfo = json.dumps(user)
    userType = Response["data"]["userType"]
    print(json.dumps(user, indent=2))
    print("sessionId =",user_sessionId)
    print(type(user_sessionId))
    # for k in user:
        # print(k,":",json.dumps(user[k], indent=2))
        # print(k)

[u'113.17.173.32', u'-', u'-', u'[24/Aug/2017:03:17:02', u'+0800]', u'"HEAD', u'/', u'HTTP/1.1"', u'200', u'0', u'"-"', u'"Mozilla/5.0', u'(compatible;', u'MSIE', u'7.0;', u'Windows', u'NT', u'5.1;', u'.NET', u'CLR', u'1.1.4322)', u'360JK', u'yunjiankong', u'1344080"', u'"-"']

加载文本文件
logs = sc.textFile("/root/access.log")
打印文件前4行
logs.take(4)
打印文件第一行
logs.first()
以空格分隔文本
logs_fields = logs.map(lambda line: line.split())
统计访问数量
ip_number = logs_fields.map(lambda fields: fields[0]).count()
访问的IP地址数
access_address = logs_fields.map(lambda fields: fields[0]).distinct().count()
状态字段截取
access_status = logs_fields.map(lambda fields: fields[8])
状态种类
status_num = logs_fields.map(lambda fields: fields[8]).distinct().count()

nginx $body_bytes_sent 单位字节
body_size = logs_fields.map(lambda fields: fields[9])
链式结构




