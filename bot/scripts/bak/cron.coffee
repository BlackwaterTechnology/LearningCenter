# Description:
 # Defines periodic executions

module.exports = (robot) ->
    room = "egZLXuXJb8SWQBRkZ"
    currentTime = new Date

    workdaysNineAm = ->
    everyFiveMinutes = ->
        robot.messageRoom room, "当前时间是#{currentTime.getYear()}/#{currentTime.getMonth()}/#{currentTme.getDay()} #{currentTime.getHours()}:#{currentTime.getMinutes()}:#{currentTime.getSeconds()}."
        console.log "每分钟函数执行了: #{room}"

    cronJob = require('cron').CronJob
    new cronJob('* 1 1 * * 1-5', workdaysNineAm, null, true, 'Asia/Shanghai')
    new cronJob('* 32 * * * *', everyFiveMinutes, null, true, 'Asia/Shanghai')
