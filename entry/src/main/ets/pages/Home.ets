import { getHomeDataApi } from '../api/home';
import { PADDING, SHADOW_RADIUS } from '../constants/size';
import { BasicDataSource } from '../Models/BasicDataSource';
import { IBannerItem, IColor, INavList, IPlanList, ITileList } from '../Models/HomeData';
import BannerLayout from '../views/Home/BannerLayout';
import NavList from '../views/Home/NavList';
import NearbyHouses from '../views/Home/NearbyHouses';
import PlanList from '../views/Home/PlanList';
import SearchBar from '../views/Home/SearchBar';
import TileList from '../views/Home/TileList';
import ScrollContainer from '../components/ScrollContainer/Index';


@Component
export default struct Home {
  @State bannerList: BasicDataSource<IBannerItem> = new BasicDataSource()
  @State planList: IPlanList = []
  @State tileList: ITileList = []
  @State navList: INavList = []
  @State adPicture: string = ''

  async getHomeData() {
    try {
      const res = await getHomeDataApi()
      this.bannerList.setList(res.bannerList)
      this.planList = res.planList
      this.tileList = res.tileList
      this.navList = res.navList
      this.adPicture = res.adPicture
    } catch (error) {
      console.error(error)
    }
  }

  aboutToAppear() {
    this.getHomeData()
  }

  @Builder
  searchBarBuilder($$: IColor) {
    SearchBar({ font_color: $$.font_color, bg_color: $$.bg_color })
  }

  @Builder
  homeContentBuilder() {
    BannerLayout({ bannerList: this.bannerList })
    Column() {
      NavList({ navList: this.navList })

      TileList({ tileList: this.tileList })

      PlanList({ planList: this.planList })

      Image(this.adPicture)
        .width('100%')
        .height(60)
        .objectFit(ImageFit.Fill)
        .margin({ top: 9 })
        .shadow({
          offsetX: 0,
          offsetY: 0,
          color: 'rgba(0, 0, 0, 0.14)',
          radius: SHADOW_RADIUS
        })
    }
    .width('100%')
    .padding({ left: PADDING, right: PADDING })

    NearbyHouses()
  }

  build() {
    ScrollContainer({
      navBuilderParam: this.searchBarBuilder,
      contentBuilderParam: () => {
        this.homeContentBuilder()
      }
    })
  }
}