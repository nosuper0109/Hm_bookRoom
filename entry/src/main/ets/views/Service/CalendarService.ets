import Card from '../../components/Card/Index';
import { BORDER_RADIUS_S } from '../../constants/size';
import { IServiceActivity } from '../../Models/ServiceData';
import Calendar from '../../utils/calendar';


@Component
export default struct CalendarService {
  @Prop serviceActivity: IServiceActivity
  @State calendarList: string[] = []

  aboutToAppear() {
    const calendar = new Calendar();
    this.calendarList = calendar.generatorCalendarList();
  }

  build() {
    Column() {
      Card({ cardPadding: 0 }) {
        Column() {
          Row() {
            Text('服务日历')
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
          .padding({ left: 8, right: 8, top: 8 })
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)

          // 日历
          Row() {
            ForEach(this.calendarList, (item: string, index) => {
              Row() {
                Text(item).fontSize(16).fontWeight(700).width(20)
                Text('月').fontSize(12).fontColor($r('app.color.gray_second')).lineHeight(18)
              }
              .backgroundColor(index === 2 ? '#CDFFD9' : '#FFF')
              .padding(index === 2 ? 6 : 0)
              .borderRadius(BORDER_RADIUS_S)
            }, (item: string) => item)
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .width('100%')
          .height(38)
          .margin({ top: 9, bottom: 12 })
          .padding({ left: 8, right: 8 })

          Column({ space: 8 }) {
            Text(this.serviceActivity.name)
              .fontSize(14)
              .fontWeight(700)
              .fontColor($r('app.color.black'))
              .width('100%')
              .textAlign(TextAlign.Start)
            Row({ space: 10 }) {
              Image(this.serviceActivity.img)
                .width(100)
                .aspectRatio(1)
                .objectFit(ImageFit.Fill)
              Column({ space: 8 }) {
                Text(this.serviceActivity.title)
                  .fontSize(14)
                  .fontColor($r('app.color.black'))
                  .margin({ top: 10 })
                Text(this.serviceActivity.subTitle)
                  .fontSize(12)
                  .fontColor($r('app.color.black'))
                Text('立即参与')
                  .width(70)
                  .height(24)
                  .backgroundColor('#CDFFD9')
                  .fontSize(12)
                  .fontColor('#1F632F')
                  .alignSelf(ItemAlign.End)
                  .textAlign(TextAlign.Center)
                  .margin({ top: 16 })
                  .borderRadius(4)
              }
              .layoutWeight(1)
              .height(100)
              .justifyContent(FlexAlign.Start)
              .alignItems(HorizontalAlign.Start)
            }
          }
          .width('100%')
          .height(140)
          .padding({
            left: 8,
            top: 8,
            right: 16,
            bottom: 8
          })
          .linearGradient({
            direction: GradientDirection.LeftBottom, // 渐变方向, // 渐变方向
            colors: [['#D0FFDB', 0], ['#FFFFFF', 0.4]] // 数组末尾元素占比小于1时满足重复着色效果
          })
        }
      }
    }
    .margin({ top: 8 })
  }
}