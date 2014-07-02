// Generated by CoffeeScript 1.7.1
(function() {
  var express, path;

  express = require("express");

  path = require("path");

  module.exports = {
    CONFIG_BASE_PATH: path.join(__dirname, "../../config/", express().get("env")),
    WECHAT_TOKEN: "heron_wechat",
    MONGODB_CONFIG_PATH: path.join(__dirname, "../../config/", express().get("env"), "mongo.config"),
    SECRET: "secret"
  };

}).call(this);

//# sourceMappingURL=consts.map