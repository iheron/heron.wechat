// Generated by CoffeeScript 1.7.1
(function() {
  var async, close, file, logger, mongoose, open, path, repository_base;

  async = require("async");

  mongoose = require("mongoose");

  path = require("path");

  file = require("../helper/file");

  logger = require("../helper/logger").getLogger("repository");

  open = function(config_path) {
    var mongo_config, options, uri;
    mongo_config = file.loadConfigFileSync(config_path);
    uri = "mongodb://" + (mongo_config.username ? "" + mongo_config.username + ":" + mongo_config.password + "@" : "") + mongo_config.host + ":" + mongo_config.port + "/" + mongo_config.database;
    options = {
      server: {
        "poolSize": mongo_config.poolsize
      }
    };
    return mongoose.createConnection(uri, options, function() {
      logger.info("connected in " + uri);
      return logger.info("connection state: " + mongoose.STATES[mongoose.connection.readyState]);
    });
  };

  close = function() {
    return mongoose.disconnect(function(err) {
      return logger.info("connection state: " + mongoose.STATES[mongoose.connection.readyState]);
    });
  };


  /**
   *
   * @model: 注入的model
   * @constructor:           # 构造函数
      @parma: mongo_config  # 注入的配置
   */

  repository_base = (function() {
    function repository_base(mongo_config) {
      if (this.connection == null) {
        this.connection = open(mongo_config);
      }
      this.connection.on("connecting", function() {
        return logger.info("connecting..");
      });
      this.connection.on("connected", function() {
        return logger.info("connected..");
      });
      this.connection.on("disconnecting", function() {
        return logger.info("disconnecting..");
      });
      this.connection.on("disconnected", function() {
        return logger.info("disconnected..");
      });
      this.connection.on("error", function() {
        this.connection.close();
        logger.info("connection state: " + mongoose.STATES[mongoose.connection.readyState]);
        return console.error.bind(console, "connect error: ");
      });
    }

    repository_base.prototype.save = function(entity, next) {
      return this.model.create(entity, next);
    };

    repository_base.prototype.update = function(doc, update, next) {
      return this.model.update(doc, update, next);
    };

    repository_base.prototype.updateOne = function(id, update, next) {
      return this.model.findOneAndUpdate(id, update, next);
    };

    repository_base.prototype.remove = function(doc, next) {
      return this.model.remove(doc, next);
    };

    repository_base.prototype.removeOne = function(id, next) {
      return this.model.findOneAndRemove(id, next);
    };

    repository_base.prototype.findAll = function(next) {
      return this.model.find(next);
    };

    repository_base.prototype.findOne = function(doc, next) {
      return this.model.findOne(doc, next);
    };

    repository_base.prototype.findWithSort = function(doc, sort, next) {
      return this.model.find(doc).sort(sort).exec(next);
    };

    repository_base.prototype.count = function(doc, next) {
      return this.model.count(doc, next);
    };


    /**
     * 分页查询
     * @param: sort  # 排序
     * @param: skip  # 跳过的数量
     * @param: limit # 返回连续的数量
     */

    repository_base.prototype.findByPage = function(doc, sort, skip, limit, next) {
      return this.model.find(doc).sort(sort).skip(skip).limit(limit).exec(next);
    };

    repository_base.prototype.close = function() {
      return this.connection.close();
    };

    repository_base.close = function() {
      return close();
    };

    return repository_base;

  })();

  module.exports = repository_base;

}).call(this);

//# sourceMappingURL=repository_base.map
