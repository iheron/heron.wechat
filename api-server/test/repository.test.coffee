repository_base = require("./require") "repository/repository_base"
user_schema = require("./require") "schema/user_schema"
consts = require("./require") "consts/consts"

assert = require "assert"


#rep = new repository_base(consts.MONGODB_CONFIG_PATH)
#rep.model = rep.connection.model("user", user_schema)
#rep.model.find (err, data)->
#  console.log data
#console.log "ok"
describe "repository_base", ->
  describe "#ctor", ->
    it "should return -1 when value is not found", ->
      assert.equal(-1 , [1..3].indexOf 5)
      assert.equal(-1 , [1..3].indexOf 10)