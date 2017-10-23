#Description
# Controls slave at event-slave.coffee
#
#Commands
#   hubot tell slave to action - emits event to slave to do the action

module.exports = (robot) ->
    robot.respond /tell slave to (.*)/i, (msg) ->
        action = msg.match[1]
        room = msg.message.room
        msg.send "master: telling slave to #{action}"
        robot.emit 'slave:command', action, room
