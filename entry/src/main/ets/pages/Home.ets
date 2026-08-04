import { getHomeDataApi } from '../api/home';
import { IBannerList, INavList, IPlanList, ITileList } from '../Models/HomeData';
import BannerLayout from '../views/Home/BannerLayout';


@Component
export default struct Home {
  @State bannerList: IBannerList = []
  @State planList: IPlanList = []
  @State tileList: ITileList = []
  @State navList: INavList = []

  async getHomeData() {
    try {
      const res = await getHomeDataApi()
      this.bannerList = res.bannerList
      this.planList = res.planList
      this.tileList = res.tileList
      this.navList = res.navList
    } catch (error) {
      console.error(error)
    }
  }

  aboutToAppear() {
    this.getHomeData()
  }

  build() {
    Scroll() {
      Column() {
        BannerLayout({ bannerList: this.bannerList })
      }
    }
    .scrollBar(BarState.Off)
    .align(Alignment.TopStart)
    .width("100%")
    .height("100%")
  }
}