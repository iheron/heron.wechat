user_repository = require "../repository/user_repository"
async = require "async"
mongoose = require "mongoose"
user_schema = require "../schema/user_schema"

user_rep = new user_repository()
user_rep.findMaxAge (err, data) ->
  console.log data
#
#async.series [
#  (step) ->
#    user_rep.findAll (err, data) ->
#      console.log data
#
#      step(null)
#  (step)->
#    if user_rep then console.log "ok" else console.log "no"
#    user_rep.findAll (err, data) ->
#      console.log data
#    step null
#  (step) ->
#    console.log "-----------------------------------"
#    user_rep = new user_repository()
#    user_rep.findAll (err, data) ->
#      console.log data
#]
#


#conn = mongoose.createConnection "mongodb://heron:123456@127.0.0.1:27017/heron_wechat"
#conn.once "open", ->
#  console.log "conn"
#console.log mongoose.STATES[conn.readyState]
#model = conn.model "user", user_schema
#console.log mongoose.STATES[conn.readyState]
#model.find (err, data) ->
#  console.log data
#  console.log mongoose.STATES[conn.readyState]
#  conn.close()
#console.log mongoose.STATES[conn.readyState]
#
#conn.once "open", ->
#  console.log "ok"
#  console.log mongoose.STATES[mongoose.connection.readyState]
#  console.log mongoose.STATES[conn.readyState]
#
#setTimeout ->
#  console.log mongoose.STATES[conn.readyState]
#, 100