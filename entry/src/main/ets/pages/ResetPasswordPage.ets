import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import { TitleBar } from '../views/TitleBar'
import { Http } from '../model/Http'
@Extend(TextInput) function inputStyle() {
  .fontSize(25)
  .placeholderFont({size:25})
  .backgroundColor(Color.Transparent)
  .borderWidth({bottom:1}) // 下边框线
  .borderRadius(0) // 圆角半径为0
  .borderColor('#ccc') // 16进制颜色
  .margin({top:10})
}

@Entry // 可以进入的一个页面
@Component
struct ResetPasswordPage {
  @State username: string = ''
  @State security: string = ''
  @State password: string = ''
  build() { // 结构体里面必须写build()
    // margin():外边距  padding():内边距
    Column() { // 垂直容器，里面的东西会自上而下垂直排列
      Column() {
        TitleBar({title: '忘记密码'})

        Text('重置密码')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 20 ,bottom:30}) // 上外边距

        TextInput({ placeholder: '请输入账号' })
          .inputStyle()
          .onChange(value => this.username = value)
        TextInput({ placeholder: '请输入密保' })
          .inputStyle()
          .onChange(value => this.security = value)
        TextInput({ placeholder: '请输入密码' })
          .inputStyle()
          .type(InputType.Password)
          .onChange(value => this.password = value)

        Button('重置密码')
          .fontSize(25)
          .height(50)
          .width('80%')
          .margin({ top: 100 })
      }.onClick(() => {
        let http = new Http('/user/update/app')
        http.get({
          username: this.username,
          security: this.security,
          password: this.password
        }).then(resp => {
          let data = http.parse(resp)
          if (data == -1) {
            promptAction.showToast({
              message: '账号不存在'
            })
          } else if (data == 0) {
            promptAction.showToast({
              message: '密保错误'
            })
          } else {
            router.pushUrl({
              url: 'pages/LoginPage'
            })
          }
        })


      })

      // 开始写最下面的容器

    }.width('100%').height('100%')
    .padding({left:10,right:10})
    .justifyContent(FlexAlign.SpaceBetween)
  }
}