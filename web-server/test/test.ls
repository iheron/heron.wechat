require!{
  co
  moment
  mongoose
  '../src/repositories/curriculum_repository': curm_rep
  '../src/repositories/class_repository': class_rep
}

curm-rep = new curm_rep!
class-rep = new class_rep!
begin-date = new Date(2014, 8, 20, 18, 30, 0)

#class-rep.findAll { _id: '54226f9bd3b74372fc21d9a9' } ,(err, data) ->
#  console.log data
main = co ->*
  for i in [ 0 to 16 ]
    if false
      doc =
        class-id: '54226f9bd3b74372fc21d9a9'
        title: '大学英语(休假)'
        description: '休假'
        start: (moment begin-date).add { weeks: i }
        end: (moment begin-date).add { weeks: i ,hours: 3 }
        allDay: false
        level: 1
    else
      doc =
        class-id: '54226f9bd3b74372fc21d9a9'
        title: '信息素养'
        description: '共计32学时，自行到网上公开课学习。'
        start: (moment begin-date).add { weeks: i }
        end: (moment begin-date).add { weeks: i ,hours: 3 }
        allDay: false
        level: 1
    res = yield (done) ->
      curm-rep.save doc, (err, data) ->
        done err, i
    console.log res

main!
#curm-rep.findAll (err, data) ->
#  console.log data.0.start.getTime()