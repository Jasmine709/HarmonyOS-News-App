
import router from '@ohos.router'
import { Nav, News } from '../model/Clazz'
import { Http } from '../model/Http'
import { NewsItem } from '../views/NewsItem'
@Entry
@Component
struct IndexPage {
  //全局变量
  //把改变的数据直接更新到页面中，@State
  @State navList: Nav[] = []//空数组
  @State index: number = 0//数组下标
  aboutToAppear() {//当页面出现时会调用该函数
    let http = new Http('/nav/app')
    http.get().then(resp =>{//后端返回的数据
      //从express拿到的是json字符串
      this.navList = http.parse(resp) //解析数据，且具有打印功能
    })
  }
  @Builder //小组件
  Nav(nav, i) {
    Text(nav.nav)
      .fontSize(this.index == i ? 25 : 20)
      .fontColor(this.index == i ? $r('app.color.blue') : Color.Black)
      .fontWeight(this.index == i ? FontWeight.Bold : FontWeight.Normal)
      .padding({left:10, right:10})//内边距
  }

  build() {
    Column() {//有且仅有一个根容器
      Tabs() {
        ForEach(this.navList, (item, i)=>{
          TabContent() {
            NewsPage({nav: item})
          }.tabBar(this.Nav(item, i))
        })
      }.width('100%')
      .onChange(i =>this.index=i)
      .barWidth('100%')
      .barMode(BarMode.Scrollable)//左右滑动效果
      //.barPosition(BarPosition.End)
    }.width('100%').height('100%')
  }
}

@Preview
@Component
struct NewsPage {
  @State isRefreshing: boolean = false
  nav: Nav = new Nav()//创建对象
  @State newsList: News[] =  [] //去express
  //获取express的新闻数据
  aboutToAppear() {
    let http = new Http('/news/app?nid='+ this.nav.id)
    http.get().then(resp=>{
      this.newsList = http.parse(resp)//解析
    })
  }
  build() {
    Refresh({ refreshing: $$this.isRefreshing, offset: 120, friction: 100 }) {
      List() {
        ForEach(this.newsList, (item, i)=>{
          ListItem() {
            NewsItem({news: item})
          }.onClick(()=>{//回调函数
            if (item.type == 1) {//购物导航中的新闻
              router.pushUrl({
                url: 'pages/OrderPage',
                params: {//向下一个页面中传参
                  news: item
                }
              })
            } else if (item.type == 2) {
              router.pushUrl({
                url: 'pages/SportPage',
                params: {//向下一个页面中传参
                  id: i+1
                }
              })
            }
          })
        })
      }.width('100%').height('100%')
    }.padding({left:10, right:10})
    .onRefreshing(() => {
      setTimeout(() => {
        //下拉刷新需要更新数据
        this.aboutToAppear()//重新加载页面
        this.isRefreshing = false
      }, 1000)
    })
  }
}