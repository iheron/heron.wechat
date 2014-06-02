express = require "express"
router = express.Router()

controller = ->
controller.wechat =
  get : (req, res, next) ->
    res.send "this is get!!!!!!!!!!!"
    

  post : (req, res, next) ->
    logger.info req.body
    res.send "this is post"

module.exports = controller