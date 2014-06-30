chai = require "chai"
expect = chai.expect
should = chai.should()

async = require "async"


test_helper = require "./test_helper"


mongoose = require "mongoose"
repository_base = test_helper.require "repository/repository_base"
user_schema = test_helper.require "schema/user_schema"
consts = test_helper.require "consts/consts"

describe "repository_base", ->
  describe "#ctor", ->
    it "open databese", (done) ->
      rep = new repository_base(consts.MONGODB_CONFIG_PATH)
      rep.model = rep.connection.model "user", user_schema

      rep.connection.once "open", (err) ->
        rep.connection.readyState.should.to.equal mongoose.STATES.connected
        done()

  describe "#insert", ->
    it "insert 10 data", (done) ->
      rep = new repository_base(consts.MONGODB_CONFIG_PATH)
      rep.model = rep.connection.model "user", user_schema
      async.each [1..10], (i, step) ->
        entity = {}
        entity.username = "test" + i
        entity.password = "test" + i
        entity.age = i
        rep.save entity, (err) ->
          step()
      , (err) ->
        done()

  describe "#findAll", ->
    it "findAll data", (done) ->
      rep = new repository_base(consts.MONGODB_CONFIG_PATH)
      rep.model = rep.connection.model "user", user_schema
      rep.findAll (err, data) ->
        done()