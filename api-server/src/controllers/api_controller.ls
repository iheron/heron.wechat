require!{
  '../consts'
}
helper-wechat = require '../helpers/wechat' <| consts.WECHAT_TOKEN
logger = require '../helpers/logger'
.get-logger 'controller'

class @wechat
  @get = ->*
    if !helper-wechat.check-signature @request.query
      @status = 200
      @body = ''
    else
      @status = 200
      @body = @request.query.echostr


  @post = ->*
    if !helper-wechat.check-signature @request.query
      @status = 200
      @body = ''
    else
      @status = 200
      helper-wechat.getMsg @req, (data) ->
        logger.info data

      helper-wechat
      .all (data) ->
      .text (data) ->
      @body = 'default ok'