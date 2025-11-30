
export class Nav {// class类
  id: number
  nav: string
  type: number
}

export class News {
  id: number
  title: string
  content: string
  ctime: string
  nid: number
  image: string
  photo: string
  price: number
  nav: string
  type: number
}

export class Sports {
  Team_Id: number
  Team_Name: string
  Team_Introduce: string
  Team_Img: string
  nid: number
}

export class Player {
  id:number
  name:string
  img:string
  team:string
}

export class Team{
  id:number
  name:string
  img:string
  introduce:string
  star:number
}