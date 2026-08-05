import { getNearbyHousesApi } from '../../api/home';
import { PADDING } from '../../constants/size';
import { BasicDataSource } from '../../Models/BasicDataSource';
import { INearbyHousesItem, ITagsItem } from '../../Models/HomeData';

@Component
export default struct NearbyHouses {
  @State nearbyHousesList: BasicDataSource<INearbyHousesItem> = new BasicDataSource()
  getNearbyHouses = async () => {
    try {
      this.nearbyHousesList.setList(await getNearbyHousesApi())
    } catch (e) {
      console.error(e)
    }
  }

  aboutToAppear(): void {
    this.getNearbyHouses()
  }

  build() {
    Column() {
      Row() {
        Text() {
          Span('周边房源')
            .fontColor($r('app.color.black'))
          Span('推荐')
            .fontColor('#36D1A1')
        }
        .fontSize(16)
        .fontWeight(700)

        Row({ space: 5 }) {
          Text('更多推荐')
            .fontSize(10)
            .fontColor($r('app.color.gray_second'))
          Image($r('app.media.right_arrow'))
            .width(4)
            .height(8)
            .fillColor($r('app.color.gray_second'))
        }
      }
      .width('100%')
      .height(44)
      .justifyContent(FlexAlign.SpaceBetween)
      .backgroundColor($r('app.color.white'))
      .padding({ left: PADDING, right: PADDING })

      Grid() {
        LazyForEach(this.nearbyHousesList, (item: INearbyHousesItem) => {
          GridItem() {
            Column() {
              Stack() {
                Image(item.housePicture)
                  .width('100%')
                  .height(120)
                  .objectFit(ImageFit.Fill)
                  .borderRadius({ topLeft: 5, topRight: 5 })
                Image($r('app.media.rectangle_bg'))
                  .width('100%')
                  .height(120)
                  .objectFit(ImageFit.Fill)
                Text(item.address)
                  .fontSize(10)
                  .fontColor($r('app.color.white'))
                  .margin({ left: 8, bottom: 7 })
              }
              .alignContent(Alignment.BottomStart)

              Column({ space: 10 }) {
                Row() {
                  Text() {
                    Span(`￥${item.rentPriceListing}`)
                      .fontSize(14)
                    Span(item.rentPriceUnit)
                      .fontSize(12)
                  }
                  .fontColor('#E03810')

                  Text(parseInt(item.rentArea) + 'm²')
                    .fontSize(10)
                    .fontColor($r('app.color.gray'))
                }
                .width('100%')
                .justifyContent(FlexAlign.SpaceBetween)

                Text(item.houseTitle)
                  .maxLines(1)
                  .textOverflow({
                    overflow: TextOverflow.Ellipsis
                  })
                  .fontSize(12)
                  .fontColor($r('app.color.black'))

                Row({ space: 12 }) {
                  ForEach(item.tags.splice(0, 2), (tag: ITagsItem, index: number) => {
                    Text(tag.name)
                      .fontSize(10)
                      .fontColor(index === 0 ? $r('app.color.white') : '#B3B3B3')
                      .height(16)
                      .padding({ left: 6, right: 6 })
                      .backgroundColor(index === 0 ? '#36D1A1' : $r('app.color.bg_gray'))
                      .borderRadius(2)

                  }, (tag: ITagsItem, index: number) => tag.name + index)
                }
                .width('100%')
                .justifyContent(FlexAlign.Start)
              }
              .padding({
                left: 10,
                top: 12,
                right: 10,
                bottom: 12
              })
              .backgroundColor($r('app.color.white'))
            }
            .width(160)
            .height(210)
          }
        }, (item: INearbyHousesItem) => item.id)
      }
      .width('100%')
      .columnsTemplate('1fr 1fr')
      .columnsGap(8)
      .rowsGap(8)
      .backgroundColor($r('app.color.bg_gray'))
      .padding({ left: PADDING, right: PADDING, top: 17 })

    }
    .margin({ top: 24 })

  }
}