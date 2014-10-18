// Generated by LiveScript 1.2.0
(function(){
  var http, coBody, views, index;
  http = require('http');
  coBody = require('co-body');
  views = require('../helpers/views');
  this.index = index = (function(){
    index.displayName = 'index';
    var prototype = index.prototype, constructor = index;
    index.get = function*(){
      this.body = yield views.hogan.render('getkey/index', null);
    };
    index.post = function*(){
      var form, data;
      form = yield coBody.form(this);
      data = yield function(done){
        return http.get(form.url, function(res){
          var html;
          html = '';
          res.setEncoding('utf8');
          res.on('data', function(chunk){
            return html += chunk;
          });
          return res.on('end', function(){
            var keys;
            keys = html.match(/[A-Z0-9]{4,6}-[A-Z0-9]{3,7}-[A-Z0-9]{3,7}-[A-Z0-9]{3,7}/g);
            return done(null, keys);
          });
        }).on('error', function(e){
          return console.log(e);
        });
      };
      this.body = yield views.hogan.render('getkey/index', {
        data: data
      });
    };
    function index(){}
    return index;
  }());
}).call(this);