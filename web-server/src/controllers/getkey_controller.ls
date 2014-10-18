require!{
  http
  'co-body'
  '../helpers/views': views
}
class @index
  @get = ->*
    @body = yield views.hogan.render 'getkey/index', null

  @post = ->*

    form = yield co-body.form @

    data = yield (done) ->
      http.get form.url, (res) ->
        html = ''
        res.setEncoding 'utf8'
        res.on 'data', (chunk) ->
          html += chunk
        res.on 'end', ->
          keys = html.match /[A-Z0-9]{4,6}-[A-Z0-9]{3,7}-[A-Z0-9]{3,7}-[A-Z0-9]{3,7}/g
          done null, keys
      .on 'error', (e) ->
        console.log e


    @body = yield views.hogan.render 'getkey/index', do
      data: data