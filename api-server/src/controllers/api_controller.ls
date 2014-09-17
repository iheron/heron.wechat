require!{
  co
  '../consts'
  '../helpers/flash'
  '../repositories/setting_repository'
}
helper-wechat = require '../helpers/wechat' <| consts.WECHAT_TOKEN

logger = require '../helpers/logger'
.get-logger 'controller'

setting_rep = new setting_repository!

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
      logger.info '------------------ api/wechat auth no ----------------------'
      @status = 200
      @body = ''
    else
      logger.info '------------------ api/wechat auth yes ----------------------'
      @status = 200

      settings = yield (done) -> setting_rep.findOne done
      xml = yield (done) ->
        helper-wechat
        .all (data) ->

        .text (data) ->
          co flash.yield-is-exists data.MsgId
          <| (err, flag) ->
            return done null, '' if flag
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

        .event (data) ->
          co flash.yield-is-exists "#{ data.FromUserName }#{ data.CreateTime }"
          <| (err, flag) ->
            return done null, '' if flag

          switch data.Event
          | 'subscribe' =>
            msg =
              FromUserName: data.ToUserName
              ToUserName: data.FromUserName
              Content: settings.welcome
            results = helper-wechat.parseMsg msg
            done null, results
          | 'unsubscribe' =>
            msg =
              FromUserName: data.ToUserName
              ToUserName: data.FromUserName
              Content: '您取消了订阅'
            results = helper-wechat.parseMsg msg
            done null, results
          | _ =>
            logger.info "has no event #{ data.Event }"
            done null, ''

        helper-wechat.getMsg @req, (data) ->
          logger.info data
      logger.info xml
      @body = xml