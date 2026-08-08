import { ICleaningServiceInfoItem, INewcomerZone } from '../../Models/ServiceData';
import Card from '../../components/Card/Index';
import { BasicDataSource } from '../../Models/BasicDataSource';


@Component
export default struct CleanService {
  @ObjectLink cleaningServiceInfoList: BasicDataSource<ICleaningServiceInfoItem>
  @Prop newcomerZone: INewcomerZone
  @State currentActivity: number = 0

  @Builder
  newPersonBuilder() {
    Card() {
      Column({ space: 8 }) {
        Text() {
          Span('新人')
            .fontColor($r('app.color.primary'))
          Span('专区')
            .fontColor($r('app.color.black'))
        }
        .fontWeight(700)
        .fontSize(16)

        Image(this.newcomerZone.img)
          .width('100%')
          .height(90)
          .objectFit(ImageFit.Fill)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
  }

  @Builder
  cleanCard() {
    Card() {
      Column({ space: 8 }) {
        Text('洁净家')
          .fontSize(16)
          .fontWeight(700)
          .fontColor($r('app.color.black'))
          .width('100%')
          .textAlign(TextAlign.Start)
        Grid() {
          LazyForEach(this.cleaningServiceInfoList, (item: ICleaningServiceInfoItem) => {
            GridItem() {
              Column({ space: 8 }) {
                Image(item.img)
                  .width(152)
                  .height(115)
                  .objectFit(ImageFit.Fill)
                Text(item.title)
                  .fontSize(14)
                  .fontWeight(700)
                  .fontColor($r('app.color.black'))
                Text(item.subTitle)
                  .fontSize(10)
                  .fontColor($r('app.color.gray_second'))
                Row({ space: 8 }) {
                  Text('到手价')
                    .fontSize(10)
                    .fontColor($r('app.color.gray_second'))
                  Text(`￥${item.priceAfterDiscounts}`)
                    .fontSize(16)
                    .fontColor('#D9351A')
                  Text(`￥${item.originalPrice}`)
                    .fontSize(10)
                    .fontColor($r('app.color.gray_second'))
                    .decoration({
                      type: TextDecorationType.LineThrough
                    })
                }
              }
              .width('100%')
              .alignItems(HorizontalAlign.Start)
            }
          }, (item: ICleaningServiceInfoItem, index: number) => item.title + index)
        }
        .columnsGap(8)
        .columnsTemplate('1fr 1fr')
      }
    }
  }

  @Builder
  contentBuilder() {
    Column({ space: 8 }) {
      this.newPersonBuilder()
      this.cleanCard()
    }
    .width('100%')
  }

  @Builder
  tabBarBuilder(title: string, subTitle: string, index: number) {
    Column({ space: 2 }) {
      Text(title)
        .fontSize(this.currentActivity === index ? 16 : 14)
        .fontColor($r('app.color.black'))
        .fontWeight(700)
      Text(subTitle)
        .fontSize(12)
        .fontColor($r('app.color.gray_second'))
      if (this.currentActivity === index) {
        Divider()
          .strokeWidth(4)
          .width(20)
          .color('#51BB9E')
          .lineCap(LineCapStyle.Round)
      }
    }
  }

  build() {
    Column() {
      Tabs({ index: $$this.currentActivity }) {
        TabContent() {
          this.contentBuilder()
        }
        .align(Alignment.Top)
        .tabBar(this.tabBarBuilder('会员精选', '专业服务', 0))

        TabContent() {
          this.contentBuilder()
        }
        .align(Alignment.Top)
        .tabBar(this.tabBarBuilder('居家保洁', '解放双手', 1))

        TabContent() {
          this.contentBuilder()
        }
        .align(Alignment.Top)
        .tabBar(this.tabBarBuilder('深层清洗', '高温蒸洗', 2))

        TabContent() {
          this.contentBuilder()
        }
        .align(Alignment.Top)
        .tabBar(this.tabBarBuilder('新居乔迁', '一站搬家', 3))
      }
      .scrollable(false)
      .barHeight(70)
      .height('auto')
    }
  }
}