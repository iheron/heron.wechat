require!{
  path
  koa
  'heron-mvc': mvc
}
app = koa!
module.exports =
  CONFIGURE: (mvc.configure.load path.join __dirname, '../../configure')
    <<< env: (mvc.configure.load path.join __dirname, '../../configure', app.['env'])
  WECHAT_TOKEN: "heron_wechat"
  # 去重闪存时间(s)
  FLASH_TIMEOUT: 10