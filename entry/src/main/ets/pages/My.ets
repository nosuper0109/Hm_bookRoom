import { IColor } from '../Models/HomeData'
import { getWindowTopHeight, rvp } from '../utils/responsive'
import { PADDING } from '../constants/size'

import ScrollContainer from '../components/ScrollContainer/Index'
import NavBar from '../views/My/NavBar'
import Bg from '../views/My/Bg'
import UserInfo from '../views/My/UserInfo'
import TimePlan from '../views/My/TimePlan'
import Order from '../views/My/Order'
import PlanList from '../views/My/PlanList'

@Component
export default struct My {
  @Builder
  navBuilder($$: IColor) {
    NavBar({ font_color: $$.font_color })
  }

  @Builder
  contentBuilder() {
    Stack() {
      Bg()
      Column() {
        UserInfo()
        TimePlan()
        Order()
        PlanList()
      }
      .padding({ left: rvp(PADDING), right: rvp(PADDING), top: rvp(44) + getWindowTopHeight() })
    }.width('100%').align(Alignment.TopStart)
  }

  build() {
    ScrollContainer({
      contentBuilderParam: () => {
        this.contentBuilder()
      },
      navBuilderParam: this.navBuilder,
    })
  }
}