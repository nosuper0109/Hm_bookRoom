import { ITileItem, ITileList } from '../../Models/HomeData';

@Component
export default struct TileList {
  @Prop tileList: ITileList

  build() {
    List({ space: 32 }) {
      ForEach(this.tileList, (item: ITileItem) => {
        ListItem() {
          Column() {
            Image(item.imageURL)
              .width('100%')
              .height(58)
            Row({ space: 5 }) {
              Text(item.title)
                .fontSize(12)
                .fontColor($r('app.color.black'))
              Text(item.sub_title)
                .fontSize(10)
                .fontColor($r('app.color.gray'))
            }
            .width('100%')
            .height(22)
            .justifyContent(FlexAlign.Start)
          }
          .width(148)
        }
      }, (item: ITileItem) => item.id + '')
    }
    .listDirection(Axis.Horizontal)
    .scrollBar(BarState.Off)
    .height(80)
    .width('100%')
    .margin({ top: 12 })
  }
}