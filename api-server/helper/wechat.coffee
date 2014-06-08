encrypt = require "./encrypt"
xml2js = require "xml2js"

parseJson = (xml) ->
  msg = {}
  xml2js.parseString xml, (err, result) ->
    data = result.xml
    msg.ToUserName = data.ToUserName[0]
    msg.FromUserName = data.FromUserName[0]
    msg.CreateTime = data.CreateTime[0]
    msg.MsgType = data.MsgType[0]
    switch msg.MsgType
      when "text"
        msg.Content = data.Content[0]
        msg.MsgId = data.MsgId[0]
  msg

parseXml = (data) ->
  MsgType = ""
  if not data.MsgType
    if data.hasOwnProperty("Content") then MsgType = "text"
    if data.hasOwnProperty("MusicUrl") then MsgType = "music"
    if data.hasOwnProperty("Articles") then MsgType = "news"
  else
    MsgType = data.MsgType

  msg = """
<xml>
<ToUserName><![CDATA[#{data.ToUserName}]]></ToUserName>
<FromUserName><![CDATA[#{data.FromUserName }]]></FromUserName>
<CreateTime>#{Date.now()/1000}"</CreateTime>
<MsgType><![CDATA[#{MsgType}]]></MsgType>
"""
  switch MsgType
    when "text"
      msg += """
<Content><![CDATA[#{data.Content or ''}]]></Content>
</xml>
"""
  msg

class wechat
  constructor: (@token) ->
  checkSignature: (parms) ->
    strHash = encrypt.sha1Hash [@token, parms.timestamp, parms.nonce].sort().join("")
    if strHash is parms.signature
      true
    else
      false
  getMsg: (req, next) ->
    xml = ""
    req.on "data", (chunk) ->
      xml += chunk
    req.on "end", ->
      next parseJson(xml)
  parseMsg: (data) ->
    parseXml data


module.exports = (token) ->
  new wechat token