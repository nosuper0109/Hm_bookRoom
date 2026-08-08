import { getServiceDataApi } from '../api/service'
import ScrollContainer from '../components/ScrollContainer/Index'
import { PADDING } from '../constants/size'
import { BasicDataSource } from '../Models/BasicDataSource'
import { IColor } from '../Models/HomeData'
import {
  ICleaningServiceInfoItem,
  IHomeServiceList,
  INewcomerZone,
  IServiceActivity
} from '../Models/ServiceData'
import Bg from '../views/Service/Bg'
import CalendarService from '../views/Service/CalendarService'
import CleanService from '../views/Service/CleanService'
import FamilyService from '../views/Service/FamilyService'
import NavBar from '../views/Service/NavBar'
import Vip from '../views/Service/Vip'

@Component
export default struct Service {
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;
  @State homeServiceList: IHomeServiceList = []
  @State serviceActivity: IServiceActivity = {} as IServiceActivity
  @State cleaningServiceInfoList: BasicDataSource<ICleaningServiceInfoItem> = new BasicDataSource()
  getServiceData = async () => {
    const res = await getServiceDataApi()
    this.homeServiceList = res.homeServiceList
    this.serviceActivity = res.serviceActivity
    this.cleaningServiceInfoList.setList(res.cleaningServiceInfo)
    this.newcomerZone = res.newcomerZone
  }
  @State newcomerZone: INewcomerZone = {} as INewcomerZone

  @Builder
  contentBuilder() {
    Stack() {
      Bg()
      Column() {
        Vip()
        FamilyService({ homeServiceList: this.homeServiceList })

        CalendarService({ serviceActivity: this.serviceActivity })

        CleanService({ cleaningServiceInfoList: this.cleaningServiceInfoList, newcomerZone: this.newcomerZone })
      }
      .width('100%')
      .padding({ left: PADDING, right: PADDING, top: 44 + this.getUIContext().px2vp(this.topRectHeight) })
    }
    .alignContent(Alignment.Top)
    .backgroundColor($r('app.color.bg_gray_second'))
  }

  @Builder
  navBarBuilder($$: IColor) {
    NavBar({ font_color: $$.font_color })
  }

  aboutToAppear(): void {
    this.getServiceData()
  }

  build() {
    ScrollContainer({
      contentBuilderParam: () => {
        this.contentBuilder()
      },
      navBuilderParam: this.navBarBuilder
    })
  }
}