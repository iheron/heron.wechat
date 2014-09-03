require! {
  'koa-mount': mount
  'koa-router': koa-router
  '../controllers/home_controller': controller
}

router = new koa-router!

router.get /^\/$/, controller.index.get

module.exports = router