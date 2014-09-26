require! {
  http
  lodash: _
  xml2js
  '../helpers/views': views
}

class @index
  @get = ->*
    url = 'http://kjm.beihangonline.com/G00001/courseware/';
    xml = yield (done) ->
      http.get 'http://kjm.beihangonline.com/G00001/courseware/imsmanifest.xml', (res) ->
        data = ''
        res.setEncoding 'utf8'
        res.on 'data', (chunk) ->
          data += chunk
        res.on 'end', ->
          done null, data

    data = yield (done) ->
      xml2js.parseString xml, (err, result) ->
        organizations = result.manifest.organizations.[0].organization.[0].item
        resources = result.manifest.resources.[0].resource

        loop-organizations = (data$, array) ->
          if array && array.length > 0
            for list in array
              item = {}
              item <<< 'title': list.title
              item <<< 'identifier': list.$.identifier
              identifierref = list.$.identifierref
              if identifierref
                resource = _.find resources, (item) ->
                  item.$.identifier == identifierref
                item <<< 'href': url + resource.$.href if resource
              data$.push item
              item.item = []
              loop-organizations item.item, list.item if list.item
            data$
        res = loop-organizations [], organizations
        done null, res
    @body = yield views.hogan.render 'topics/index', do
      data: data