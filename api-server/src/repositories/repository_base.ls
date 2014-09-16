require!{
  path
  mongoose
  '../helpers/file'
}

logger = require '../helpers/logger'
.getLogger 'repository'

open = (mongo_config) ->
  uri = "mongodb://#{if mongo_config.username then "#{mongo_config.username}:#{mongo_config.password}@" else ""}#{mongo_config.host}:#{mongo_config.port}/#{mongo_config.database}"
  options =
    server:
      "poolSize": mongo_config.poolsize
  mongoose.createConnection uri, options, ->
    logger.info "connected in #{uri}"
    logger.info "connection state: #{mongoose.STATES[mongoose.connection.readyState]}"

close = ->
  mongoose.disconnect (err) ->
    logger.info "connection state: #{mongoose.STATES[mongoose.connection.readyState]}"

###*
#
# @model: 注入的model
# @constructor:           # 构造函数
#    @parma: mongo_config  # 注入的配置
###
class repository_base
  (mongo_config) ->
    @connection ?= open mongo_config
    @connection.on "connecting", -> logger.info "connecting.."
    @connection.on "connected", -> logger.info "connected.."
    @connection.on "disconnecting", -> logger.info "disconnecting.."
    @connection.on "disconnected", -> logger.info "disconnected.."
    @connection.on "error", ->
      @connection.close()
      logger.info "connection state: #{mongoose.STATES[mongoose.connection.readyState]}"
      console.error.bind console, "connect error: "

  save: (entity, next) ->
    @model.create entity, next

  update: (doc, update, next) ->
    @model.update doc, update, next

  updateOne: (id, update, next) ->
    @model.findOneAndUpdate id, update, next

  remove: (doc, next) ->
    @model.remove doc, next

  removeOne: (id, next) ->
    @model.findOneAndRemove id, next

  findAll: (next) ->
    @model.find next

  findOne: (doc, next) ->
    @model.findOne doc, next

  findWithSort: (doc, sort, next) ->
    @model.find doc
    .sort sort
    .exec next

  count: (doc, next) ->
    @model.count doc, next

  ###*
  # 分页查询
  # @param: sort  # 排序
  # @param: skip  # 跳过的数量
  # @param: limit # 返回连续的数量
  ###
  findByPage: (doc, sort, skip, limit, next) ->
    @model.find doc
    .sort sort
    .skip skip
    .limit limit
    .exec next

  close: ->
    @connection.close()
  @close = ->
    close()

module.exports = repository_base