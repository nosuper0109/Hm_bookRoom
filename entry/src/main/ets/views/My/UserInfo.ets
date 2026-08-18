import Avatar from '../../components/Avatar/Index'

import { rvp } from '../../utils/responsive'
import { getUserInfoApi } from '../../api/login'

@Component
export default struct UserInfo {
  @StorageLink('token') @Watch('onTokenChange') token: string = ''
  @State nickname: string = ''
  @State avatarSrc: string = ''
  getUserInfo = async () => {
    try {
      const res = await getUserInfoApi()
      if (res) {
        this.nickname = res.nickname
        this.avatarSrc = res.avatar
      } else {
        this.token = ''
      }
    } catch {
      this.token = ''
    }

  }
  @Consume('navPathStack') pathStack: NavPathStack = new NavPathStack()

  onTokenChange() {
    if (this.token) {
      this.getUserInfo()
    } else {
      this.nickname = ''
      this.avatarSrc = ''
    }
  }

  aboutToAppear(): void {
    this.getUserInfo()
  }

  build() {
    Row({ space: rvp(10) }) {
      Avatar({ src: this.avatarSrc, avatarSize: rvp(60) })
      Column({ space: rvp(4) }) {
        Text(this.token ? `Hi，${this.nickname}` : 'Hi，小谷粒')
          .fontSize(rvp(16))
          .fontColor($r('app.color.white'))
          .fontWeight(700)
        Text('谷粒点15')
          .fontSize(rvp(12))
          .fontColor($r('app.color.white'))
      }.alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .onClick(() => {
      if (!this.token) {
        this.pathStack.pushPathByName('LoginPhone', null)
      }
    })
  }
}