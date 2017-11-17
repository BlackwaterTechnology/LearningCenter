#Descriptioin
process.env.HUBOT_WEATHER_API_URL ||= 'http://api.openweathermap.org/data/2.5/weather?units=imperial&appid=78ddb7de9387146563946428003b39f1&q=guangzhou'
module.exports = (robot) ->
    robot.hear /天气|tianqi|weather/i, (msg) ->
        url = process.env.HUBOT_WEATHER_API_URL
        msg.robot.http(url).get() (err, res, body) ->
            data = JSON.parse(body)
            weather = [ "#{Math.round(data.main.temp)} degrees" ]
            for w in data.weather
                weather.push w.description
                msg.send "It`s #{weather.join(', ')} in #{data.name}, #{data.sys.country}"
