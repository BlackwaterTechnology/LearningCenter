#Description
module.exports = (robot) ->
    robot.catchAll (res) ->
        res.send "我是智能助手hobo,问我问题可以'@' me,如果想和我自由聊天请指明在对我说话，列如:hobo,工作做完了吗；hobo,晚上请你吃饭"
