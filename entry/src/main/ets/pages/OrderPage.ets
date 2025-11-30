import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import { News } from '../model/Clazz'
import { Http } from '../model/Http'
import { TitleBar } from '../views/TitleBar'

@Extend(TextInput) function inputStyle() {
  .fontSize(25)
  .placeholderFont({size:25})
  .backgroundColor(Color.Transparent)
  .borderWidth({bottom:1})//下边框线
  .borderRadius(0)//圆角半径为0
  .borderColor('#ccc')//16进制颜色
  .margin({top:10})
}
//接收上一个页面传递的参数
let news = router.getParams()['news'] as News

@Entry
@Component
struct OrderPage {
  @State name: string = '张三'
  @State mobile: string = '18611223344'
  @State address: string = '曲阜师范大学'
  @State count: string = '1'
  build() {
    Column() {
      TitleBar({title: '订单填写'})
      Text(news.title)
      .fontSize(30)
      .margin({bottom:10})
      if (news.image) {
        Image(Http.host + news.image)
          .width(200)
          .height(200)
      }
      Text(news.price+'元/件') //数字-->字符串
        .margin({top:10, bottom:10})
      TextInput({placeholder:'请输入姓名', text: this.name})
        .inputStyle()
        .onChange(value =>this.name = value)
      TextInput({placeholder:'请输入手机', text: this.mobile})
        .inputStyle()
        .onChange(value =>this.mobile = value)
      TextInput({placeholder:'请输入地址', text: this.address})
        .inputStyle()
        .onChange(value =>this.address = value)
      TextInput({placeholder:'请输入数量', text: this.count})
        .inputStyle()//将写的内容直接赋值到对于的变量
        .onChange(value =>this.count = value)
      Button('直接购买')
        .fontSize(25)
        .height(50)
        .width('80%')
        .margin({top:30})
        .onClick(()=>{//设置点击事件
          let http = new Http('/order/add')
          http.get({
            name: this.name,//全局变量赋值
            mobile: this.mobile,
            address: this.address,
            count: this.count,
            pid: news.id,
          }).then(resp => {
            let result = http.parse(resp)
            if (result) {
              promptAction.showToast({
                message: '购买成功'
              })
            } else {
              promptAction.showToast({
                message: 'express报错'
              })
            }
          })
        })
    }.padding({left:10, right:10})
  }
}