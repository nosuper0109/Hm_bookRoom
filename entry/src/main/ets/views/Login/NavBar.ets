import { PADDING } from '../../constants/size'

@Component
export default struct NavBar {
  @StorageProp('topRectHeight') topRectHeight: number = 0
  @Consume('navPathStack') pathStack: NavPathStack = new NavPathStack()

  build() {
    Stack() {
      Image($r('app.media.arrow_left'))
        .width(24)
        .height(24)
        .objectFit(ImageFit.Fill)
        .onClick(() => {
          this.pathStack.pop()
        })
        .layoutGravity(LocalizedAlignment.TOP_START)
      Text('验证码登录')
        .fontSize(16)
        .fontColor($r('app.color.black'))
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(44)
    .margin({ top: 11 })
    .padding({ left: PADDING, right: PADDING, top: this.getUIContext().px2vp(this.topRectHeight) })
  }
}