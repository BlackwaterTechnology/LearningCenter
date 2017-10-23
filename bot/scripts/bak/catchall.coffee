#descripton
#回答所有未匹配的消息
module.exports = (robot) ->
    robot.catchAll (res) ->
        res.send "Nothing Found:#{res.mesege.txt}"
