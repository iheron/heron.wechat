assert = require "assert"
process.env.LIB_COV
describe "Array", ->
  describe "#indexOf", ->
    it "should return -1 when value is not found", ->
      assert.equal(-1 , [1..3].indexOf 5)
      assert.equal(-1 , [1..3].indexOf 10)