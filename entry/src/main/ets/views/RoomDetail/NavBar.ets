import { PADDING } from '../../constants/size';

@Extend(Image)
function imageStyle() {
  .width(24)
  .height(24)
  .objectFit(ImageFit.Fill)
  .fillColor($r('app.color.black'))
}

@Component
export default struct NavBar {
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;
  @Prop title: string = ''

  build() {
    Row() {
      Image($r('app.media.arrow_left'))
        .imageStyle()
      Text(this.title)
        .fontSize(12)
        .fontColor($r('app.color.black'))
      Blank()
      Image($r('app.media.share'))
        .imageStyle()
        .width(20)
        .height(20)
    }
    .width('100%')
    .height(44)
    .padding({ top: this.getUIContext().px2vp(this.topRectHeight), left: PADDING, right: PADDING })
  }
}