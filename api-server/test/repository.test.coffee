test_helper = require "./test_helper"
mongoose = require "mongoose"
repository_base = test_helper.require "repository/repository_base"
user_schema = test_helper.require "schema/user_schema"
consts = test_helper.require "consts/consts"

describe "repository_base", ->
  describe "#ctor", ->
    it "should return -1 when value is not found", ->
      rep = new repository_base(consts.MONGODB_CONFIG_PATH)
      rep.model = rep.connection.model("user", user_schema)

      rep.save {username: "test",password:"test",age:11},(err)->
        console.log err