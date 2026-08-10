import { PADDING } from '../../constants/size'

@Component
export default struct NavBar {
  // @Consume('navPathStack') navPathStack: NavPathStack

  build() {
    Stack() {
      Text('房源推荐')
        .fontSize(16)
        .fontColor($r('app.color.black'))
        .width('100%')
        .textAlign(TextAlign.Center)

      Image($r('app.media.arrow_left'))
        .width(24)
        .height(24)
        .objectFit(ImageFit.Fill)
        .onClick(() => {
          // this.navPathStack.pop()
        })
    }
    .padding({ left: PADDING, right: PADDING })
    .alignContent(Alignment.Start)
    .width('100%')
    .height(44)
  }
}