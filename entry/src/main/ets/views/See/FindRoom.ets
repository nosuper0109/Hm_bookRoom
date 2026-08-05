import { PADDING } from '../../constants/size'

@Component
export default struct FindRoom {
  build() {
    Column() {
      Image($r('app.media.see_findRoom'))
        .width(58)
        .height(23)
        .objectFit(ImageFit.Fill)
        .margin({ left: 4 })
      Text('发现你想看的房子')
        .fontSize(12)
        .fontColor($r('app.color.black'))
        .margin({ left: 4, top: 20 })
      Image($r('app.media.see_blank'))
        .width(234)
        .height(221)
        .objectFit(ImageFit.Fill)
        .alignSelf(ItemAlign.Center)
        .margin({ top: 8, bottom: 10 })
      Text('暂无想看的房源，试试如下找房方式')
        .alignSelf(ItemAlign.Center)
        .fontSize(16)
        .fontColor($r('app.color.black'))
      Image($r('app.media.see_banner'))
        .width(328)
        .height(80)
        .margin({ top: 20 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding({
      left: PADDING,
      right: PADDING,
      top: 50
    })
  }
}