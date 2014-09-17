// Generated by LiveScript 1.2.0
(function(){
  var consts, repository_base, setting_schema, setting_repository;
  consts = require('../consts');
  repository_base = require('./repository_base');
  setting_schema = require('../schemas/setting_schema');
  setting_repository = (function(superclass){
    var prototype = extend$((import$(setting_repository, superclass).displayName = 'setting_repository', setting_repository), superclass).prototype, constructor = setting_repository;
    function setting_repository(){
      setting_repository.superclass.call(this, consts.CONFIGURE.env.mongo);
      this.model = this.connection.model('setting', setting_schema);
    }
    return setting_repository;
  }(repository_base));
  module.exports = setting_repository;
  function extend$(sub, sup){
    function fun(){} fun.prototype = (sub.superclass = sup).prototype;
    (sub.prototype = new fun).constructor = sub;
    if (typeof sup.extended == 'function') sup.extended(sub);
    return sub;
  }
  function import$(obj, src){
    var own = {}.hasOwnProperty;
    for (var key in src) if (own.call(src, key)) obj[key] = src[key];
    return obj;
  }
}).call(this);
