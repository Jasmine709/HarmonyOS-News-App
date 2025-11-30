
import router from '@ohos.router'
import http from '@ohos.net.http'
import { TitleBar } from '../views/TitleBar'
import promptAction from '@ohos.promptAction'
import { Http } from '../model/Http'

@Extend(TextInput) function inputStyle() {
  .fontSize(25)
  .placeholderFont({size:25})
  .backgroundColor(Color.Transparent)
  .borderWidth({bottom:1})//下边框线
  .borderRadius(0)//圆角半径为0
  .borderColor('#ccc')//16进制颜色
  .margin({top:10})
}

@Entry
@Component

struct RegistePage {
  @State username: string = ''
  build() {
      Column(){
        TitleBar({title: '账号注册'})
        Column(){
          Text('注册一个新账号')
            .fontSize(30)
            .fontColor(Color.Black)
          TextInput({placeholder: '请输入用户名'})
            .inputStyle()
          TextInput({placeholder: '请输入密码'})
            .inputStyle()
            .type(InputType.Password)
          TextInput({placeholder: '密保'})
            .inputStyle()
          Row() {
            Text('已有账号？立即登录')
              .fontSize(20)
              .fontColor($r('app.color.blue'))
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/LoginPage'
                })
              })
          }.width('100%')
          .margin({top:10})
          .justifyContent(FlexAlign.SpaceBetween)
          Button('确定注册')
            .fontSize(25)
            .height(50)
            .width('80%')
            .margin({top:30})
            .onClick(() => {
               router.pushUrl({
                 url: 'pages/LoginPage'
               })
            })
        }
      }.width('100%') .height('100%')
  }
}