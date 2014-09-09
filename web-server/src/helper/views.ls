require! {
  fs
  path
  co
  'co-views': views
}

read = (path$) ->
  return fs.readFileSync path$, 'utf8'

class view
  @hogan = views (path.join __dirname, '../../views'), do
    ext: 'hjs'
    map:
      hjs: 'hogan'

  @hogan <<<
    layout: undefined
    partials: undefined
    render: (path$, opt) ~>
      layout? = opt.layout if opt
      layout? = @hogan.layout
      partials = {}
      if @hogan && @hogan.partials
        for k, v of @hogan.partials
          partials.[k] = v
      if opt && opt.partials
        for k, v of opt.partials
          partials.[k] = v

      ~>*

        if !layout
          html = yield @hogan path$, opt
        else
          opt$ = opt || {}
          opt$ <<< yield: yield @hogan path$, opt$
          opt$ <<< partials: partials

          content = read opt$.filename

          tags = content.match /({{#yield-\w+}})/g
          yields = {}
          if tags
            for item in tags
              tag = (item.match /{{#([\w-]+)}}/).[1]
              oTag = "{{##tag}}"
              cTag = "{{/#tag}}"
              text = content.substring(content.indexOf(oTag) + oTag.length, content.indexOf(cTag))
              yields.[tag.replace('yield-', '')] = text
          opt$ <<< yields: yields
          html = yield @hogan layout, opt$
        return html

module.exports = view