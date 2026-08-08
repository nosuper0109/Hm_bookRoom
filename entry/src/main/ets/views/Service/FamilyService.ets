import Card from '../../components/Card/Index';
import { IHomeServiceItem, IHomeServiceList } from '../../Models/ServiceData';


@Component
export default struct FamilyService {
  @Prop homeServiceList: IHomeServiceList

  build() {
    Column() {
      Card() {
        Column() {
          Row() {
            Text('家庭服务')
              .fontSize(16)
              .fontColor($r('app.color.black'))
            Row({ space: 10 }) {
              Text('全部服务')
                .fontSize(12)
                .fontColor($r('app.color.gray'))
              Image($r('app.media.right_arrow'))
                .width(4)
                .height(9)
                .objectFit(ImageFit.Fill)
            }
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)

          Grid() {
            ForEach(this.homeServiceList, (item: IHomeServiceItem) => {
              GridItem() {
                Column({ space: 10 }) {
                  Image(item.icon)
                    .width(24)
                    .height(24)
                    .objectFit(ImageFit.Fill)
                  Text(item.title)
                    .fontSize(12)
                    .fontColor($r('app.color.black'))
                }
              }
              .height(48)
            }, (item: IHomeServiceItem, index: number) => item.title + index)
          }
          .rowsTemplate('1fr 1fr 1fr')
          .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
          .columnsGap(3)
          .rowsGap(23)
          .margin({ top: 10, bottom: 18 })
        }
        .width('100%')
        .height(252)
      }
    }
    .margin({ top: 43 })
  }
}