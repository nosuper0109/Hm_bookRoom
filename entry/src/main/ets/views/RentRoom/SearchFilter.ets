import { PADDING } from '../../constants/size'

@Component
export default struct SearchFilter {
  build() {
    Row() {
      Row({ space: 3 }) {
        Text('位置')
          .fontSize(14)
          .fontColor('#333')
        Image($r('app.media.arrow_down_1'))
          .width(12)
          .height(12)
          .objectFit(ImageFit.Fill)
      }

      Row({ space: 3 }) {
        Text('户型')
          .fontSize(14)
          .fontColor('#333')
        Image($r('app.media.arrow_down_1'))
          .width(12)
          .height(12)
          .objectFit(ImageFit.Fill)
      }

      Row({ space: 3 }) {
        Text('租金')
          .fontSize(14)
          .fontColor('#333')
        Image($r('app.media.arrow_down_1'))
          .width(12)
          .height(12)
          .objectFit(ImageFit.Fill)
      }

      Row({ space: 3 }) {
        Text('排序')
          .fontSize(14)
          .fontColor('#333')
        Image($r('app.media.arrow_down_1'))
          .width(12)
          .height(12)
          .objectFit(ImageFit.Fill)
      }
    }
    .width('100%')
    .height(44)
    .padding({ left: PADDING, right: PADDING })
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}