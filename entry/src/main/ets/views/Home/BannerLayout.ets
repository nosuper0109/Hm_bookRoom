import { BasicDataSource } from '../../Models/BasicDataSource'
import { IBannerItem } from '../../Models/HomeData'

@Component
export default struct BannerLayout {
  @ObjectLink bannerList: BasicDataSource<IBannerItem>

  build() {
    Swiper() {
      LazyForEach(this.bannerList, (item: IBannerItem) => {
        Image(item.imageURL)
          .width('100%')
          .objectFit(ImageFit.Fill)
      }, (item: IBannerItem) => item.id + '')
    }
    .indicator( // 设置圆点导航点样式
      new DotIndicator()
        .color($r('app.color.indicator_color'))
        .selectedColor($r('app.color.indicator_active_color')))
    .autoPlay(true)
    .height(211 - 36)
    .width('100%')
  }
}