import Avatar from '../../components/Avatar/Index'

import { rvp } from '../../utils/responsive'

@Component
export default struct UserInfo {
  @State avatarSrc: string = ''
  @Consume('navPathStack') pathStack: NavPathStack = new NavPathStack()

  build() {
    Row({ space: rvp(10) }) {
      Avatar({ src: this.avatarSrc, avatarSize: rvp(60) })
      Column({ space: rvp(4) }) {
        Text('Hi，小谷粒').fontSize(rvp(16)).fontColor($r('app.color.white')).fontWeight(700)
        Text('谷粒点15').fontSize(rvp(12)).fontColor($r('app.color.white'))
      }.alignItems(HorizontalAlign.Start)
    }.margin({ top: rvp(44) }).width('100%')
    .onClick(() => {
      this.pathStack.pushPathByName('LoginPhone', null)
    })
  }
}