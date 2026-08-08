@Component
export default struct Vip {
  build() {
    Stack() {
      Image($r('app.media.service_vip'))
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Fill)
      Image($r('app.media.service_crown'))
        .width(18)
        .height(18)
        .objectFit(ImageFit.Fill)
        .margin({ left: 39, top: 13 })
    }
    .alignContent(Alignment.TopStart)
    .margin({ top: 5 })
    .width(328)
    .height(100)
  }
}