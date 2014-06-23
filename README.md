heron.wechat
============

Heron's wechat project.

This is my first project about Nodejs.

MVC反射机制
-----------
controllers里以controller结尾的文件会解析为控制器文件
忽略前缀最后的下划线“_”
routes里有与controllers里同名的文件则按找route的规则解析，同样文件名必须以route结尾

### controller
    解析后缀为controller的文件，不区分大小写，忽略连接下划线“_”
    如 api_controller, apiController, apicontroller都是有效的命名，他们都会解析到： /api

    (function() {
      this.action = (function() {
        function action1() {}

        action.get = function(req, res, next) {
          return res.send("get in test");
        };

        action.post = function(req, res, next) {
          return res.send("post in test");
        };

        return action;

      })();

      module.exports = this;

    }).call(this);

    给暴露的函数并绑定key：action，必须有可遍历的key, value组 key是action名称，value是包含的解析方式同样需要可遍历为key, value
    解析路径到：get:/api/action 和 post:/api.action
    每一个action有4种解析方式，分别为get, post, put, delete

### route
    如果routes有和controlls里相同前缀的文件，会优先按routes里的路由机制解析
    同样忽略大小写和连接下划线“_”

    (function() {
      var controller, express, router;

      express = require("express");

      controller = require("../controllers/api_controller");

      router = express.Router();

      router.route("/wechat").get(controller.wechat.get).post(controller.wechat.post);

      module.exports = router;

    }).call(this);

    自定义配置router的方法。
