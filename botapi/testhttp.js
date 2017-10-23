function getsolution(text){
var http = require('http');
var querystring = require('querystring');
//json转换为字符串
var data = querystring.stringify({
    'cmd':"chat",
    'appid':"f64bb9acedce3b525169c7ed03cf1d2f",
    'userid':"05A5FEA6B92C9852C5EA9D4B348079869",
    'text':text,
    'location':""
    });
var options = {
    host: 'idc.emotibot.com',
    port:'80',
    path:'/api/ApiKey/openapi.php',
    method: 'POST',
    headers: {
        'content-Type':'application/x-www-form-urlencoded',
    }
};
var req = http.request(options, function(res) {
    res.setEncoding('utf8');
    res.on('data', function (chunk){
        onetimetoken_data = JSON.parse(chunk);
//        console.log(onetimetoken_data);
        var solution;
        for (i=0;i<onetimetoken_data.data.length;i++)
        {
        console.log(onetimetoken_data.data[i].value + "测试"); 
        solution = onetimetoken_data.data[i].value;
        }
        return solution;
        console.log(solution);
    });
   
});
req.write(data);
req.end();
}
texts = getsolution("来个笑话");
console.log(texts)
