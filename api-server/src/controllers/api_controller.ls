require!{
  '../consts'
}
helper-wechat = require '../helpers/wechat' <| consts.WECHAT_TOKEN
logger = require "../helpers/logger"
.getLogger("controller")

class @wechat
  @get = ->*
    if !helper-wechat.check-signature @request.query
      @status = 200
      @body = ''
    else
      @status = 200
      @body = @request.query.echostr