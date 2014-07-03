mongoose = require "mongoose"

userSchema = new mongoose.Schema
  username:
    type: String
    required: true
  password:
    type: String
    required: true
  age:
    type: Number
  create_time:
    type: Date
    default: Date.now

module.exports = userSchema