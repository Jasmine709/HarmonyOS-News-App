import http from '@ohos.net.http';

export class Http {//后端程序的端口
  static host = 'http://localhost:3000'
  project = '' // express项目名
  url = ''
  //构造函数
  constructor(url) { //传入/nav
    this.url = url
  }

  get(data?) {
    let params = ''
    if (data) {
      params = '?'
      for (let k in data) {
        params += k + '=' + data[k] + '&'
      } // 可以把最后一个&去掉
      params = params.substring(0, params.length - 1)
    }
    return http.createHttp().request(encodeURI(Http.host + this.project + this.url + params))
  }

  parse(resp) {
    let data = `${resp.result}`
    console.log(data.split('/').join('\\'))
    return JSON.parse(data)
  }
}