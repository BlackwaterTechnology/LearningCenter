#description
#用户输入cal或日历即回复当月日历
child_process = require('child_process')
module.exports = (robot) ->
    robot.respond /(cal|日历) ?/i, (res) ->
        child_process.exec 'cal', (err, stdout, stderr) ->
            res.send(stdout)
