// Generated by LiveScript 1.2.0
(function(){
  var co, moment, mongoose, curm_rep, class_rep, curmRep, classRep, beginDate, main;
  co = require('co');
  moment = require('moment');
  mongoose = require('mongoose');
  curm_rep = require('../src/repositories/curriculum_repository');
  class_rep = require('../src/repositories/class_repository');
  curmRep = new curm_rep();
  classRep = new class_rep();
  beginDate = new Date(2014, 8, 15, 18, 30, 0);
  main = co(function*(){
    var i$, ref$, len$, i, doc, res;
    for (i$ = 0, len$ = (ref$ = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]).length; i$ < len$; ++i$) {
      i = ref$[i$];
      if (false) {
        doc = {
          classId: '54226f9bd3b74372fc21d9a9',
          title: '模拟电路与数字电路(休假)',
          description: '休假',
          start: moment(beginDate).add({
            weeks: i
          }),
          end: moment(beginDate).add({
            weeks: i,
            hours: 3
          }),
          allDay: false,
          level: 0
        };
      } else {
        doc = {
          classId: '54226f9bd3b74372fc21d9a9',
          title: '信息素养',
          description: '共计32学时，自行到网上公开课学习。',
          start: moment(beginDate).add({
            weeks: i
          }),
          end: moment(beginDate).add({
            weeks: i,
            hours: 3
          }),
          allDay: false,
          level: 1
        };
      }
      res = yield fn$;
      console.log(res);
    }
    function fn$(done){
      return curmRep.save(doc, function(err, data){
        return done(err, i);
      });
    }
  });
  main();
}).call(this);
