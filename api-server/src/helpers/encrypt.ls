require!{
   crypto
}
class encrypt
  @sha1Hash = (str) ->
    hasher = crypto.createHash "sha1"
    hasher.update str
    .digest "hex"
module.exports = encrypt