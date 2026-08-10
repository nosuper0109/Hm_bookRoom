import { getCityListApi, getDistrictListApi, getProvinceListApi } from '../../api/rentRoom'
import { PADDING } from '../../constants/size'
import {
  ICityItem,
  ICityList,
  IDistrictItem,
  IDistrictList,
  IProvinceItem,
  IProvinceList
} from '../../Models/RentRoomData'
import { globalEmitter } from '../../utils/emitter'

@Component
export default struct SearchFilter {
  @State filterOptions: string[] = ['位置', '户型', '租金', '排序']
  @State isShowFilterArea: boolean = false
  @State currentFilterText: string = ''
  @State provinceList: IProvinceList = [] // 省
  @State cityList: ICityList = [] // 市
  @State districtList: IDistrictList = [] // 区
  @State provinceCode: string = '' // 省code
  @State cityCode: string = '' // 市code
  @State districtCode: string = '' // 区code
  @State districtName: string = '' // 区name
  @State submitDistrictName: string = ''
  @State submitProvinceCode: string = ''
  @State submitCityCode: string = ''
  @State submitDistrictCode: string = ''

  // 获取省市区
  async getProvinceList() {
    const provinceList = await getProvinceListApi()
    this.provinceList = provinceList
    this.provinceCode = this.provinceCode || provinceList[0].code;
    this.getCityList()
  }

  async getCityList() {
    const cityList = await getCityListApi(this.provinceCode)
    this.cityList = cityList;
    this.cityCode = this.cityCode || cityList[0].code;
    this.getDistrictList()
  }

  async getDistrictList() {
    const districtList = await getDistrictListApi(this.cityCode)
    this.districtList = districtList
    this.districtCode = this.districtCode || districtList[0].code;
  }

  showFilterArea(text: string) {
    if (this.currentFilterText == text) {
      this.hideFilterArea()
      return
    }
    this.isShowFilterArea = true
    if (text === '位置') {
      this.getProvinceList()
    }
    this.provinceCode = this.submitProvinceCode
    this.cityCode = this.submitCityCode
    this.districtCode = this.submitDistrictCode
  }

  hideFilterArea() {
    this.isShowFilterArea = false
    this.currentFilterText = ''
  }

  @Builder
  positionBuilder() {
    Column() {
      Row() {
        List() {
          ForEach(this.provinceList, (province: IProvinceItem) => {
            ListItem() {
              Text(province.name)
                .fontSize(12)
                .fontColor(this.provinceCode == province.code ? $r('app.color.primary') : $r('app.color.black'))
            }
            .height(30)
            .width('100%')
            .padding({
              left: 16,
              top: 6,
              right: 16,
              bottom: 6
            })
            .align(Alignment.Start)
            .onClick(() => {
              this.provinceCode = province.code
              this.cityCode = ''
              this.districtCode = ''
              this.getCityList()
            })
          }, (province: IProvinceItem) => province.code)
        }
        .scrollBar(BarState.Off)
        .backgroundColor($r('app.color.white'))
        .height('100%')
        .layoutWeight(1)

        List() {
          ForEach(this.cityList, (city: ICityItem) => {
            ListItem() {
              Text(city.name)
                .fontSize(12)
                .fontColor(this.cityCode == city.code ? $r('app.color.primary') : $r('app.color.black'))
            }
            .align(Alignment.Start)
            .height(30)
            .width('100%')
            .padding({
              left: 16,
              top: 6,
              right: 16,
              bottom: 6
            })
            .onClick(() => {
              this.cityCode = city.code
              this.districtCode = ''
              this.getDistrictList()
            })
          }, (city: ICityItem) => city.code)
        }
        .alignListItem(ListItemAlign.Start)
        .scrollBar(BarState.Off)
        .backgroundColor('#EBEBEB')
        .height('100%')
        .layoutWeight(1)

        List() {
          ForEach(this.districtList, (district: IDistrictItem) => {
            ListItem() {
              Text(district.name)
                .fontSize(12)
                .fontColor(this.districtCode == district.code ? $r('app.color.primary') : $r('app.color.black'))
            }
            .align(Alignment.Start)
            .height(30)
            .width('100%')
            .padding({
              left: 16,
              top: 6,
              right: 16,
              bottom: 6
            })
            .onClick(() => {
              this.districtCode = district.code
              this.districtName = district.name
            })
          }, (district: IDistrictItem) => district.code)
        }
        .scrollBar(BarState.Off)
        .backgroundColor('#E6E6E6')
        .height('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .layoutWeight(1)

      Row({ space: 22 }) {
        Button('重置')
          .type(ButtonType.Normal)
          .fontSize(12)
          .fontColor($r('app.color.gray_second'))
          .backgroundColor('#F0F0F0')
          .width('30%')
          .borderRadius(4)
          .onClick(() => {
            this.provinceCode = this.provinceList[0].code
            this.cityCode = ''
            this.districtCode = ''
            this.getProvinceList()
          })
        Button('查看房源')
          .fontSize(12)
          .type(ButtonType.Normal)
          .fontColor($r('app.color.white'))
          .backgroundColor('#67C0A8')
          .layoutWeight(1)
          .borderRadius(4)
          .onClick(() => {
            this.hideFilterArea()
            this.submitDistrictName = this.districtName
            this.submitProvinceCode = this.provinceCode
            this.submitCityCode = this.cityCode
            this.submitDistrictCode = this.districtCode

            globalEmitter.emit('search', {
              provinceCode: this.provinceCode,
              cityCode: this.cityCode,
              districtCode: this.districtCode
            })
          })

      }
      .padding(16)
      .width('100%')
      .height(60)
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  layoutBuilder() {
    Text('户型')
  }

  @Builder
  princeBuilder() {
    Text('租金')
  }

  @Builder
  sortBuilder() {
    Text('排序')
  }

  getPositionName = (text: string) => {
    if (text === '位置') {
      return this.submitDistrictName || text
    } else {
      return text
    }
  }
  getPositionColor = (text: string) => {
    if (text === '位置') {
      return this.submitDistrictName ? $r('app.color.primary') : '#333333'
    } else {
      return '#333333'
    }
  }

  build() {
    Column() {
      Row() {
        ForEach(this.filterOptions, (text: string) => {
          Row({ space: 3 }) {
            Text(this.getPositionName(text))
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .constraintSize({ maxWidth: 56 })
              .fontSize(14)
              .fontColor(this.getPositionColor(text))
            Image(this.currentFilterText == text ? $r('app.media.arrow_down_2') : $r('app.media.arrow_down_1'))
              .width(12)
              .height(12)
              .objectFit(ImageFit.Fill)
          }
          .onClick(() => {
            this.showFilterArea(text)
            this.currentFilterText = text
          })
        }, (text: string) => text)
      }
      .width('100%')
      .height(44)
      .padding({ left: PADDING, right: PADDING })
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 44 })
      .backgroundColor($r('app.color.white'))

      if (this.isShowFilterArea) {
        Column() {
          if (this.currentFilterText === '位置') {
            this.positionBuilder()
          } else if (this.currentFilterText === '户型') {
            this.layoutBuilder()
          } else if (this.currentFilterText === '租金') {
            this.princeBuilder()
          } else {
            this.sortBuilder()
          }
        }
        .height(300)
        .backgroundColor($r('app.color.white'))
        .width('100%')

        Column() {
        }
        .backgroundColor('rgba(0,0,0,0.7)')
        .width('100%')
        .layoutWeight(1)
        .onClick(() => {
          this.hideFilterArea()
        })
      }
    }
    .width('100%')
  }
}