@Component
export default struct Bg {
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;

  build() {
    Stack() {
      Image($r('app.media.service_bg'))
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Fill)
      Image($r('app.media.service_arrow_down'))
        .width(10)
        .objectFit(ImageFit.Fill)
        .margin({ bottom: 5 })
    }
    .width(360)
    .height(221 - 36 + this.getUIContext().px2vp(this.topRectHeight))
    .alignContent(Alignment.Bottom)
  }
}