import { getRentRoomListApi } from '../../api/rentRoom';
import { PADDING } from '../../constants/size';
import { BasicDataSource } from '../../Models/BasicDataSource';
import { ITagsItem } from '../../Models/HomeData';
import { IGetRentRoomListParams, IRentRoomItem } from '../../Models/RentRoomData';
import { globalEmitter } from '../../utils/emitter';

@Component
export default struct RoomList {
  @State roomList: BasicDataSource<IRentRoomItem> = new BasicDataSource()
  @State total: number = 0
  @State isEnd: boolean = false
  @State searchOptions: IGetRentRoomListParams = {
    "page": 1,
    "limit": 10,
    "provinceCode": "",
    "cityCode": "",
    "districtCode": "",
    "minRent": "",
    "maxRent": "",
    "paymentType": "",
    "orderBy": "",
    "orderType": ""
  }

  async getRentRoomList() {
    const res = await getRentRoomListApi(this.searchOptions)
    if (this.searchOptions.page == 1) {
      this.roomList.setList(res.records)
    } else {
      this.roomList.pushData(res.records)
    }
    this.total = res.total
  }

  loadMore = () => {
    this.searchOptions.page++
    if (this.roomList.totalCount() >= this.total) {
      this.isEnd = true
      return
    }
    this.isEnd = false
    this.getRentRoomList()
  }

  @Builder
  footerBuilder() {
    Row() {
      if (!this.isEnd) {
        Refresh({ refreshing: !this.isEnd })
        Text('加载中...')
          .fontSize(14)
          .fontColor($r('app.color.gray'))
      } else {
        Text('到底啦...')
          .fontSize(14)
          .fontColor($r('app.color.gray'))
      }

    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height(40)
  }

  aboutToAppear(): void {
    this.getRentRoomList()
    this.registerGlobalEmitter()
  }

  registerGlobalEmitter() {
    globalEmitter.on('search', async (searchOptions: Partial<IGetRentRoomListParams>) => {
      this.searchOptions.page = 1;
      this.searchOptions.limit = 10;
      if (searchOptions.provinceCode) {
        this.searchOptions.provinceCode = searchOptions.provinceCode;
      }
      if (searchOptions.cityCode) {
        this.searchOptions.cityCode = searchOptions.cityCode;
      }
      if (searchOptions.districtCode) {
        this.searchOptions.districtCode = searchOptions.districtCode;
      }
      this.searchOptions.paymentType = searchOptions.paymentType;
      this.searchOptions.minRent = searchOptions.minRent;
      this.searchOptions.maxRent = searchOptions.maxRent;
      this.searchOptions.orderBy = searchOptions.orderBy;
      this.searchOptions.orderType = searchOptions.orderType;


      this.getRentRoomList()
    })
  }

  build() {
    Scroll() {
      WaterFlow({
        footer: this.footerBuilder
      }) {
        LazyForEach(this.roomList, (item: IRentRoomItem) => {
          FlowItem() {
            Column() {
              if (item.activity) {
                Column() {
                  Row({ space: 4 }) {
                    Image(item.activity.icon)
                      .width(26)
                      .height(26)
                      .objectFit(ImageFit.Fill)
                    Text(item.activity.title)
                      .fontSize(14)
                      .fontColor($r('app.color.black'))
                      .fontWeight(700)
                  }

                  Text(Reflect.get(item.activity, '#text'))
                    .padding({
                      left: 8,
                      top: 4,
                      right: 10,
                      bottom: 4
                    })
                    .margin({ top: 3, bottom: 3 })
                    .fontSize(10)
                    .fontColor(item.activity.textColor)
                    .fontWeight(700)
                    .backgroundColor(item.activity.textBackGroundColor)
                    .width('100%')
                    .textAlign(TextAlign.LEFT)
                }
                .padding({ top: 12, left: 10, right: 10 })
                .width('100%')
                .borderRadius({ topLeft: 5, topRight: 5 })
                .alignItems(HorizontalAlign.Start)
              }
              Stack() {
                Image(item.housePicture)
                  .width('100%')
                  .height(item.activity ? 165 : 120)
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
              .padding(item.activity ? { left: 10, right: 10 } : null)
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
            .height(item.activity ? 320 : 210)
            .backgroundColor($r('app.color.white'))
          }
        }, (item: IRentRoomItem) => item.id)
      }
      .width('100%')
      .columnsTemplate('1fr 1fr')
      .columnsGap(8)
      .rowsGap(8)
      .padding({
        top: 4,
        left: PADDING,
        right: PADDING,
        bottom: PADDING
      })
    }
    .backgroundColor($r('app.color.bg_gray'))
    .padding({ top: 88 })
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.Spring)
    .onReachEnd(this.loadMore)
  }
}