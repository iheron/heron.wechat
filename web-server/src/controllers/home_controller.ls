class @index
  @get = ->*
    query = @query
    req = @req
    console.log req
    @body = "get in home;query: #query ;  req: #req"

module.exports = @