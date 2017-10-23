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

getresponse = `function(statement, msg){
    var exec = require('child_process').exec;
    exec('/usr/bin/chatter.py'+" "+statement, function(Error,stdout,stderr){
        console.log(Error);
        console.log(stdout);
        console.log(stderr);
        if(stdout.length >1){
        msg.send(stdout);
        }
   })
}`

write = `function(string){
    var fs = require("fs");
    fs.appendFile('/home/hubot/chatter/corpus.txt', string+'\n', function (err) {
      if (err) throw err;
       })
}`


startTrain = `function(str){
    console.log(str)
    console.log('执行训练开始');
    var exec = require('child_process').exec;
    exec('/home/hubot/chatter/scripts/train.py', function(Error,stdout,stderr){
       console.log(stderr);
       console.log(Error);

})
}`

module.exports = (robot) ->

   robot.hear /tutu (.*)/i, (msg) ->
      statement = msg.match[1]
      getresponse statement,msg

   robot.hear /(leanning|学习) (.*)/i, (msg) ->
      string=msg.match[2]
      write string
      msg.send "已经学习，告诉我训练之后就可以回答你。"

   robot.hear /train|训练/i, (msg) ->
      msg.send '开始训练'
      startTrain '启动训练'
      msg.send '训练完毕'
      




