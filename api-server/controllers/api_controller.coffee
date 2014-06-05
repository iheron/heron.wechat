consts = require "../consts/consts"
encrypt = require "../helper/encrypt"
express = require "express"
router = express.Router()



controller = ->

controller.wechat =
  get: (req, res, next) ->
    token = consts.WECHAT_TOKEN
    signature = req.query.signature
    timestamp = req.query.timestamp
    nonce = req.query.nonce
#    echostr = req.query.echostr
    str = [token, timestamp, nonce].sort().join("")
    strHash = encrypt.sha1Hash(str)
    if strHash is signature
      res.send 200, req.query.echostr
    else
      res.send 200, false


  post: (req, res, next) ->
    res.send "this is post"

module.exports = controller