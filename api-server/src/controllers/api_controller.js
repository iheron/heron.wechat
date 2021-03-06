// Generated by LiveScript 1.2.0
(function(){
  var co, consts, flash, setting_repository, helperWechat, logger, setting_rep, wechat;
  co = require('co');
  consts = require('../consts');
  flash = require('../helpers/flash');
  setting_repository = require('../repositories/setting_repository');
  helperWechat = require('../helpers/wechat')(consts.WECHAT_TOKEN);
  logger = require('../helpers/logger').getLogger('controller');
  setting_rep = new setting_repository();
  this.wechat = wechat = (function(){
    wechat.displayName = 'wechat';
    var prototype = wechat.prototype, constructor = wechat;
    wechat.get = function*(){
      if (!helperWechat.checkSignature(this.request.query)) {
        this.status = 200;
        this.body = '';
      } else {
        this.status = 200;
        this.body = this.request.query.echostr;
      }
    };
    wechat.post = function*(){
      var settings, xml;
      if (!helperWechat.checkSignature(this.request.query)) {
        logger.info('------------------ api/wechat auth no ----------------------');
        this.status = 200;
        this.body = '';
      } else {
        logger.info('------------------ api/wechat auth yes ----------------------');
        this.status = 200;
        settings = yield function(done){
          return setting_rep.findOne(done);
        };
        xml = yield function(done){
          helperWechat.all(function(data){}).text(function(data){
            var msg, results;
            co(flash.yieldIsExists(data.MsgId))(function(err, flag){
              if (flag) {
                return done(null, '');
              }
            });
            msg = {
              FromUserName: data.ToUserName,
              ToUserName: data.FromUserName,
              Content: "<a href=\"http://96.47.232.148:3000/\">点击访问主页</a>"
            };
            results = helperWechat.parseMsg(msg);
            return done(null, results);
          }).image(function(data){
            var msg, results;
            msg = {
              FromUserName: data.ToUserName,
              ToUserName: data.FromUserName,
              Content: "这是一个图片"
            };
            results = helperWechat.parseMsg(msg);
            return done(null, results);
          }).event(function(data){
            var msg, results;
            co(flash.yieldIsExists(data.FromUserName + "" + data.CreateTime))(function(err, flag){
              if (flag) {
                return done(null, '');
              }
            });
            switch (data.Event) {
            case 'subscribe':
              msg = {
                FromUserName: data.ToUserName,
                ToUserName: data.FromUserName,
                Content: "" + settings.welcome + "\n<a href=\"http://96.47.232.148:3000/\">点击访问主页</a>"
              };
              results = helperWechat.parseMsg(msg);
              return done(null, results);
            case 'unsubscribe':
              msg = {
                FromUserName: data.ToUserName,
                ToUserName: data.FromUserName,
                Content: '您取消了订阅'
              };
              results = helperWechat.parseMsg(msg);
              return done(null, results);
            default:
              logger.info("has no event " + data.Event);
              return done(null, '');
            }
          });
          return helperWechat.getMsg(this.req, function(data){
            return logger.info(data);
          });
        };
        logger.info(xml);
        this.body = xml;
      }
    };
    function wechat(){}
    return wechat;
  }());
}).call(this);
