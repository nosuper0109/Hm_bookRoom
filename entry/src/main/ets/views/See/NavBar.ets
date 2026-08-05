import { PADDING } from '../../constants/size';

@Extend(Image)
function see_icon() {
  .width(20)
  .height(20)
  .objectFit(ImageFit.Fill)
  .fillColor($r('app.color.black'))
}

@Extend(Text)
function see_font() {
  .fontSize(10)
  .fontColor($r('app.color.black'))
}

@Component
export default struct NavBar {
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;

  build() {
    Column() {
      Row() {
        Row({ space: 6 }) {
          Image($r('app.media.see_bag'))
            .width(16)
            .height(16)
            .objectFit(ImageFit.Fill)
          Text('填写通勤地址')
            .fontSize(12)
            .fontColor($r('app.color.black'))
        }

        Row({ space: 28 }) {
          Column({ space: 1 }) {
            Image($r('app.media.message'))
              .see_icon()
            Text('消息')
              .see_font()
          }

          Column({ space: 1 }) {
            Image($r('app.media.see_journey'))
              .see_icon()
            Text('行程')
              .see_font()
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

