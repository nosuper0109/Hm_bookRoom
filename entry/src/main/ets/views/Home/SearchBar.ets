import { PADDING } from '../../constants/size'

@Component
export default struct SearchBar {
  build() {
    Row({ space: PADDING }) {
      Text('北京')
        .fontSize(14)
        .fontColor($r('app.color.white'))
      Row() {
        Image($r('app.media.search'))
          .width(18)
          .height(18)
        TextInput({ placeholder: '公司/地铁/小区，马上搜索' })
          .placeholderFont({ size: 10 })
          .height(40)
          .backgroundColor($r('app.color.white'))
          .borderRadius(20)
          .padding({ left: 15 })
          .layoutWeight(1)
        Divider()
          .vertical(true)
          .strokeWidth(1)
          .height(32)
          .color($r('app.color.divider_color'))
        Image($r('app.media.position'))
          .width(18)
          .height(18)
          .margin({ left: PADDING })
      }
      .padding({ left: PADDING, right: PADDING })
      .width(244)
      .height(38)
      .backgroundColor($r('app.color.white'))
      .borderRadius(20)

      Image($r('app.media.message'))
        .width(24)
        .height(24)
    }
  }
}