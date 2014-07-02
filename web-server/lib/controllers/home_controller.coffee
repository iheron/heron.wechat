consts = require "../consts/consts"

class @index
  @get: (req, res, next) ->

    res.render "home/index",
      title: "首页"

module.exports = @