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
    logger.info '------------------ post api/wechat ----------------------'
    if !helper-wechat.check-signature @request.query
      logger.info '------------------ api/wechat auth no ----------------------'
      @status = 200
      @body = ''
    else
      logger.info '------------------ api/wechat auth yes ----------------------'
      @status = 200

      data = yield (done) ->
        helper-wechat.getMsg @req, (data) ->
          logger.info data
        helper-wechat
        .all (data) ->
        .text (data) ->
          msg =
            FromUserName: data.ToUserName
            ToUserName: data.FromUserName
            Content: ">>> #{ data.Content } <<<"
          results = helper-wechat.parseMsg msg
          done null, results
        .image (data) ->
          msg =
            FromUserName: data.ToUserName
            ToUserName: data.FromUserName
            Content: "这是一个图片"
          results = helper-wechat.parseMsg msg
          done null, results
      @body = data