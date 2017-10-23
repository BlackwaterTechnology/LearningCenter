# Description:  
# 这里可以获取网页的标题
module.exports = (robot) ->  
  robot.router.get "/version", (req, res) ->  
    res.end robot.version
