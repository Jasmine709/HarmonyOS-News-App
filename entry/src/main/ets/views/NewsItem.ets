//需要预览
import { News } from '../model/Clazz'
import { Http } from '../model/Http'
// 不是完整的页面，是一个页面碎片
@Preview
@Component
export struct NewsItem {
  @State typeArr: string[] = ['新闻', '购物', '体育']
  news: News = new News()
  build() {
    Column() {
      Row() {
      Text(this.typeArr[this.news.type])
        .fontColor($r('app.color.blue'))
        .borderWidth(1)
        .borderColor($r('app.color.blue'))
        .padding({top:2, bottom:2, left:10, right:10})
        .borderRadius(4)
      Text(this.news.title)
        .fontWeight(FontWeight.Bold)
        .fontSize(21)//新闻标题
        .margin({left:10})
      }.width('100%')
      .margin({top:15})

      Text(this.news.content)
        .alignSelf(ItemAlign.Start)//在侧轴的某个位置
        .margin({top:10, bottom:10})
        .fontSize(20)
      Row() {
        if (this.news.image) {
          Image(Http.host + this.news.image)
            .width(this.news.photo?'48%':'50%')
            .height(this.news.photo?120:150)
            .borderRadius(10)
        }
        if (this.news.photo) {
          Image(Http.host + this.news.photo)
            .width('48%')
            .height(120)
            .borderRadius(10)
        }
      }.width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      // .margin({ left:10 , right:10 })
      Text(this.news.price?this.news.price+'元':this.news.ctime)
        .alignSelf(ItemAlign.Start)
        .fontColor(Color.Gray)
        .margin({left:10,bottom:15,top:10})

    }.width('100%')
    .borderWidth({bottom:1})
    .borderColor('#ddd') //浅灰色
  }
}