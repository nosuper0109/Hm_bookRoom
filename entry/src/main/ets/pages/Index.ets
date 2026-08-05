import Home from './Home'
import See from './See'
import Service from './Service'
import My from './My'
import Discover from './Discover'
import { window } from '@kit.ArkUI'

@Entry
@Component
struct Index {
  windowStage: window.WindowStage = AppStorage.get("windowStage") as window.WindowStage;
  // How to get the main window TODO 为了预览器正常需要注释
  // mainWin: window.Window = this.windowStage.getMainWindowSync();
  @State CurrentActiveIndex: number = 1;
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;

  @Builder
  tabBarBuilder(image: Resource, activeImage: Resource, text: string, activeIndex: number) {
    Column() {
      Image(this.CurrentActiveIndex === activeIndex ? activeImage : image)
        .width(28)
        .aspectRatio(1)
      Text(text)
        .fontSize(10)
    }
  }

  changeBarContentColor = (index: number) => {
    // if (index === 0) {
    //   // TODO 为了预览器正常需要注释
    //   this.mainWin.setWindowSystemBarProperties({
    //     statusBarContentColor: '#ffffff'
    //   })
    // } else {
    //   // TODO 为了预览器正常需要注释
    //   this.mainWin.setWindowSystemBarProperties({
    //     statusBarContentColor: '#000000'
    //   })
    // }
  }

  aboutToAppear(): void {
    this.changeBarContentColor(this.CurrentActiveIndex)
  }

  build() {
    Tabs({ barPosition: BarPosition.End, index: this.CurrentActiveIndex }) {
      TabContent() {
        Home()
      }
      .tabBar(this.tabBarBuilder($r('app.media.tabbar_home'), $r('app.media.tabbar_home_active'), '首页', 0))

      TabContent() {
        See()
      }
      .tabBar(this.tabBarBuilder($r('app.media.tabbar_see'), $r('app.media.tabbar_see_active'), '想看', 1))


      TabContent() {
        Service()
      }
      .tabBar(this.tabBarBuilder($r('app.media.tabbar_service'), $r('app.media.tabbar_service_active'), '服务', 2))

      TabContent() {
        Discover()
      }
      .tabBar(this.tabBarBuilder($r('app.media.tabbar_discover'), $r('app.media.tabbar_discover_active'), '发现', 3))

      TabContent() {
        My()
      }
      .tabBar(this.tabBarBuilder($r('app.media.tabbar_my'), $r('app.media.tabbar_my_active'), '我的', 4))
    }
    .barHeight(50 + this.getUIContext().px2vp(this.bottomRectHeight))
    .scrollable(false)
    .onChange((index: number) => {
      this.CurrentActiveIndex = index
      this.changeBarContentColor(index)
    })
  }
}