crypto = require "crypto"
encrypt = ->
encrypt.sha1Hash = (str) ->
  hasher = crypto.createHash "sha1"
  hasher.update str
  .digest "hex"
module.exports = encrypt