require!{
  "./encrypt"
  xml2js
  events
}
emitter = new events.EventEmitter()

parseJson = (xml) ->
  msg = {}
  xml2js.parseString xml, (err, result) !->
    data = result.xml
    msg.ToUserName = data.ToUserName.[0]
    msg.FromUserName = data.FromUserName.[0]
    msg.CreateTime = data.CreateTime.[0]
    msg.MsgType = data.MsgType.[0]
    switch msg.MsgType
    | 'text' =>
      msg.Content = data.Content.[0]
      msg.MsgId = data.MsgId.[0]
      emitter.emit('text', msg)
    | 'image' =>
      msg.PicUrl = data.PicUrl.[0]
      msg.MsgId = data.MsgId.[0]
      msg.MediaId = data.MediaId.[0]
      emitter.emit('image', msg)
    | 'voice' =>
      msg.MediaId = data.MediaId.[0]
      msg.Format = data.Format.[0]
      msg.MsgId = data.MsgId.[0]
      emitter.emit('voice', msg)
    | 'video' =>
      msg.MediaId = data.MediaId.[0]
      msg.ThumbMediaId = data.ThumbMediaId.[0]
      msg.MsgId = data.MsgId.[0]
      emitter.emit("video", msg)
    | 'location' =>
      msg.Location_X = data.Location_X.[0]
      msg.Location_Y = data.Location_Y.[0]
      msg.Scale = data.Scale.[0]
      msg.Label = data.Label.[0]
      msg.MsgId = data.MsgId.[0]
      emitter.emit('location', msg)
    | 'link' =>
      msg.Title = data.Title.[0]
      msg.Description = data.Description.[0]
      msg.Url = data.Url.[0]
      msg.MsgId = data.MsgId.[0]
      emitter.emit('link', msg)
    | 'event' =>
      msg.Event = data.Event.[0]
      msg.EventKey = data.EventKey.[0]
      emitter.emit('event', msg)
  msg

parseXml = (data) ->
  MsgType = ""
  if !data.MsgType
    if data.hasOwnProperty('Content') then MsgType = "text"
    if data.hasOwnProperty('MusicUrl') then MsgType = "music"
    if data.hasOwnProperty('Articles') then MsgType = "news"
  else
    MsgType = data.MsgType

  msg = """
        <xml>
        <ToUserName><![CDATA[#{ data.ToUserName || '' }]]></ToUserName>
        <FromUserName><![CDATA[#{ data.FromUserName || '' }]]></FromUserName>
        <CreateTime>#{ '' + Date.now() / 1000 }"</CreateTime>
        <MsgType><![CDATA[#{ MsgType || '' }]]></MsgType>
        """
  switch MsgType
  | 'text' =>
    msg += """
           <Content><![CDATA[#{ data.Content || '' }]]></Content>
           </xml>
           """
  | 'image' =>
    msg += """
           <Image>
           <MediaId><![CDATA[#{ data.MediaId || '' }]]></MediaId>
           </Image>
           </xml>
           """
  | 'voice' =>
    msg += """
           <Voice>
           <MediaId><![CDATA[#{ data.MediaId || '' }]]></MediaId>
           <Title><![CDATA[#{ data.Title || '' }]]></Title>
           <Description><![CDATA[#{ data.Description || '' }]]></Description>
           </Voice>
           </xml>
           """
  | 'video' =>
    msg += """
           <Video>
           <MediaId><![CDATA[#{ data.MediaId || '' }]]></MediaId>
           </Video>
           </xml>
           """
  | 'music' =>
    msg += """
           <Music>
           <Title><![CDATA[#{ data.Title || '' }]]></Title>
           <Description><![CDATA[#{ data.Description || '' }]]></Description>
           <MusicUrl><![CDATA[#{ data.MusicUrl || '' }]]></MusicUrl>
           <HQMusicUrl><![CDATA[#{ data.HQMusicUrl || data.MusicUrl || '' }]]></HQMusicUrl>
           <ThumbMediaId><![CDATA[#{ data.ThumbMediaId || '' }]]></ThumbMediaId>
           </Music>
           </xml>
           """

  | 'news' =>
    ArticlesStr = ''
    ArticleCount = data.Articles.length
    for i in data.Articles
      ArticlesStr += """
                     <item>
                     <Title><![CDATA[#{ data.Articles.[i].Title || '' }]]></Title>
                     <Description><![CDATA[#{ data.Articles.[i].Description || '' }]]></Description>
                     <PicUrl><![CDATA[#{ data.Articles.[i].PicUrl || '' }]]></PicUrl>
                     <Url><![CDATA[#{ data.Articles.[i].Url ||'' }]]></Url>
                     </item>
                     """
    msg += "<ArticleCount>" + ArticleCount + "</ArticleCount><Articles>" + ArticlesStr + "</Articles></xml>";
  msg

class wechat
  (@token) ->
  check-signature: (parms) ->
    if !@token || !parms || !parms.timestamp || !parms.nonce || !parms.signature
      return false
    strHash = encrypt.sha1Hash [ @token, parms.timestamp, parms.nonce ].sort().join('')
    if strHash == parms.signature
      true
    else
      false

  all: (next) ->
    emitter.on('text', next)
    emitter.on('image', next)
    emitter.on('location', next)
    emitter.on('link', next)
    emitter.on('event', next)
    emitter.on('voice', next)
    emitter.on('video', next)
    @

  text: (next) ->
    emitter.on('text', next)
    @

  image: (next) ->
    emitter.on('image', next)
    @

  location: (next) ->
    emitter.on('location', next)
    @

  link: (next) ->
    emitter.on('link', next)
    @

  event: (next) ->
    emitter.on('event', next)
    @

  voice: (next) ->
    emitter.on('voice', next)
    @

  video: (next) ->
    emitter.on('video', next)
    @

  getMsg: (req, next) ->
    xml = ""
    req.on "data", (chunk) ->
      xml += chunk
    req.on "end", ->
      next parseJson(xml)

module.exports = (token) -> new wechat token
