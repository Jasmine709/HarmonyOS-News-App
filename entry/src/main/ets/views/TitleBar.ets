import router from '@ohos.router'
@Preview
@Component
export  struct TitleBar {
  @Prop title: string;
  build() {
    Row() {
      Image($r('app.media.ic_back'))
        .width(40)
        .height(40)
        .onClick(()=>{
          router.back()// 返回上一页
        })
      Text(this.title)
        .fontSize(30)
        .margin({left:20})
    }.width('100%')
    .padding(10)
  }
}