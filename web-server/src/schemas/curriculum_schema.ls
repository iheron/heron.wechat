require!{
  mongoose
}

curriculum-schema = new mongoose.Schema do
  class-id:                               # 班级ID
    type: mongoose.Schema.ObjectId
  title:                                  # 标题
    type: String
  description:                            # 描述
    type: String
  start:                                  # 开始时间
    type: Date
  end:                                    # 结束时间
    type: Date
  allDay:                                 # 是否整天
    type: Boolean
  level:                                  # 重要级别, 数字越大越重要
    type: Number




module.exports = curriculum-schema