# Description
# <带上我的名字和我畅快的聊天，列如“tutu,今晚我请你吃饭！”>
#
# Dependencies:
# "<module name>": "<module version>"
#
# Configuration:
# LIST_OF_ENV_VARS_TO_SET
#
# Commands:
# hubot <trigger> - <what the respond trigger does>
# <trigger> - <what the hear trigger does>
#
# URLS:
# GET /path?param=<val> - <what the request does>
#
# Notes:
# <optional notes required for the script>
#
# Author:
# <github username of the original script author>
getsolution = `function(text, msg){
var http = require('http');
var querystring = require('querystring');
//json转换为字符串
var data = querystring.stringify({
    'key': '64a83358b7a34acbbaecedfd7c3c576b',
    'info': text,
    'userid':"hobo",
    });
var options = {
    host: 'www.tuling123.com',
    port:'80',
    path:'/openapi/api',
    method: 'POST',
    headers: {
        'content-Type':'application/x-www-form-urlencoded',
    }
};
var req = http.request(options, function(res) {
    res.setEncoding('utf8');
    var receiveData = "";
    res.on('data', function (chunk){
        receiveData += chunk;
        }).on('end', function () {
        re_data = JSON.parse(receiveData);
        var lists = re_data.list;
        var code=re_data.code;
        console.log(code);
        if (code == 100000)
        {
        msg.send(re_data.text);
        }
        else if (code == 200000)
        {
        msg.send(re_data.text);
        msg.send(re_data.url);
        }
         else if (code == 302000 )
        {
        msg.send(re_data.text);
        for (i=0; i<lists.length; i++)
        {
          msg.send(lists[i].article); 
          msg.send(lists[i].detailurl);
          msg.send(lists[i].icon);
        }
        }
        else if (code == 308000 )
        {
        msg.send(re_data.text);
        for (i=0; i<lists.length; i++)
        {
          msg.send(lists[i].name);
          msg.send(lists[i].info);
          msg.send(lists[i].detailurl);
          msg.send(lists[i].icon);
        }
        }
        else
       {
        msg.send('和我聊天就好了！');
       }
    });
});
req.write(data);
req.end();
}`
module.exports = (robot) ->
#    robot.respond /jump/i, (msg) ->
#
    robot.hear /hobo( |,)(.*)/i, (msg) ->
        usermsg = msg.match[2]
#        msg.send usermsg
        requestData = getsolution usermsg,msg
