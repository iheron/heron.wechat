// Generated by CoffeeScript 1.7.1(function() {  var crypto, encrypt;  crypto = require("crypto");  encrypt = (function() {    function encrypt() {}    encrypt.sha1Hash = function(str) {      var hasher;      hasher = crypto.createHash("sha1");      return hasher.update(str).digest("hex");    };    return encrypt;  })();  module.exports = encrypt;}).call(this);//# sourceMappingURL=encrypt.map