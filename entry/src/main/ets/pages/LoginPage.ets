import router from '@ohos.router'
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

@Entry //可以进入的一个页面
@Component
struct LoginPage {
  build() {//结构体必须有build
    //margin():外边距， padding():内边距
    Column() {//垂直容器，里面的东西自上而下自动排列
      Column() {
        TitleBar({title: '账号登录'})
        Image($r('app.media.ic_student'))
          .width(150)
          .height(150)
          .margin({top:40})
        Text('锋云新闻')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .margin({top:20})
        Text('登录后可以使用更多功能')
          .fontSize(20)
          .fontColor(Color.Gray)
          .margin({top:10, bottom:20})
        TextInput({placeholder:'请输入账号'})
          .inputStyle()
        TextInput({placeholder:'请输入密码'})
          .inputStyle()
          .type(InputType.Password)
        Row() {//水平排列
          Text('记住密码')
            .fontSize(20)
            .fontColor($r('app.color.blue'))

          Text('忘记密码')
            .fontSize(20)
            .fontColor($r('app.color.blue'))
            .onClick(()=>{
              router.pushUrl({
                url:'pages/ResetPasswordPage'
              })
            })
        }.width('100%')
        .margin({top:10})
        .justifyContent(FlexAlign.SpaceBetween)
        Button('登录')
          .fontSize(25)
          .height(50)
          .width('80%')
          .margin({top:30})
        Button('账号注册')
          .fontSize(20)
          .height(50)
          .width('80%')
          .margin({top:10})
          .fontColor(Color.Black)
          .backgroundColor(Color.Transparent)
      }
      //写最下面的容器
      Row({space:20}) {
        Image($r('app.media.apple'))
          .width(60)
          .width(60)
          .borderRadius(30)
        Image($r('app.media.kiwifruit'))
          .width(60)
          .width(60)
          .borderRadius(30)
      }.margin({bottom:20})
    }.width('100%').height('100%')
    .padding({left:10, right:10})
    .justifyContent(FlexAlign.SpaceBetween)
  }
}