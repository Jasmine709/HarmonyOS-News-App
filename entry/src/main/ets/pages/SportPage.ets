import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import { Player, Team } from '../model/Clazz'
import { Http } from '../model/Http'
import { TitleBar } from '../views/TitleBar'

@Entry
@Component
struct SportPage {
  @State baseUrl: string = 'http://localhost:3000/file/'
  @State playerList:Player[] = [];
  @State teamList:Team[] = [];
  @State team:Team = new Team();
  @State cnt:number=1;
  @State flag:boolean = false;
  aboutToAppear() {
    const params = router.getParams();
    let http = new Http('/team/app')
    http.get({
      id: params['id'],
    }).then(resp =>{//后端返回的数据
      //从express拿到的是json字符串
      this.teamList = http.parse(resp) //解析数据，且具有打印功能
      this.team = this.teamList[0]
      this.cnt = this.team.star
    })
    let http1 = new Http('/player/app/')
    http1.get({
      id:params['id']
    }).then(resp =>{//后端返回的数据
      //从express拿到的是json字符串
      this.playerList = http.parse(resp) //解析数据，且具有打印功能
    })
  }
  build() {
    Column() {
      TitleBar({title:this.team.name})
      // 简介
      List() {
        ListItem() {
          Image(this.baseUrl+this.team.img)
            .width(350)
            .height(200)
            .margin({ left: 10, right: 10 })
        }

        ListItem() {
          Text('球队简介：' + this.team.introduce)
            .fontSize(20)
            .margin({ left: 20, right: 20 })
        }
        ListItem() {
          Button('点赞   '+this.cnt)
            .margin({top:10,left:230})
            .onClick(()=>{
                if(!this.flag) {
                  this.flag = true;
                  console.log(this.flag?"!":'2')
                  this.cnt ++;
                  new Http('/team/app/'+this.team.id).get()
                  promptAction.showToast({
                    message: '点赞成功'
                  })
                } else {
                  promptAction.showToast({
                    message: '点过了哦'
                  })
                }
            })
        }
        ListItem() {
          Text('球队成员照片')
            .fontSize(20)
            .width('100%')
            .height('100')
            .margin({ left: 10, right: 10 })
        }
        ForEach(this.playerList, item => {
          ListItem() {
            Column() {
              Image(this.baseUrl + item.img)
                .width('100%')
              Text(item.name)
                .width('100%')
                .fontSize(18)
            }
          }
        })
      }
    }.width('100%').height('100%').margin({ left: 10, right: 10 })
  }
}