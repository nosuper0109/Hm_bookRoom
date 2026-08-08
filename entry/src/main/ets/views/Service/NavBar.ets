import { PADDING } from '../../constants/size';

@Extend(Image)
function see_icon() {
  .width(20)
  .height(20)
  .objectFit(ImageFit.Fill)
  .fillColor($r('app.color.white'))
}

@Extend(Text)
function see_font() {
  .fontSize(10)
  .fontColor($r('app.color.white'))
}

@Component
export default struct NavBar {
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;
  @Prop font_color: string

  build() {
    Column() {
      Row() {
        Row({ space: 6 }) {
          Text('请选择地址')
            .fontSize(12)
            .fontColor(this.font_color)
          Image($r('app.media.service_down_pull'))
            .width(6)
            .height(6)
            .objectFit(ImageFit.Fill)
            .margin({ bottom: 2 })
            .fillColor(this.font_color)
        }

        Row({ space: 28 }) {
          Column({ space: 1 }) {
            Image($r('app.media.message'))
              .see_icon()
              .fillColor(this.font_color)
            Text('消息')
              .see_font()
              .fontColor(this.font_color)
          }

          Column({ space: 1 }) {
            Image($r('app.media.service_customer'))
              .see_icon()
              .fillColor(this.font_color)
            Text('客服')
              .see_font()
              .fontColor(this.font_color)
          }
        }
      }
      .width('100%')
      .height(44)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .padding({ left: PADDING, right: PADDING, top: this.getUIContext().px2vp(this.topRectHeight) })

  }
}

