import { getCityListApi, getDistrictListApi, getProvinceListApi } from '../../api/rentRoom'
import { PADDING } from '../../constants/size'
import {
  ICityItem,
  ICityList,
  IDistrictItem,
  IDistrictList,
  IProvinceItem,
  IProvinceList,
  IRentPriceItem,
  IRentPriceList,
  ISortItem,
  ISortList
} from '../../Models/RentRoomData'
import { globalEmitter } from '../../utils/emitter'

@Component
export default struct SearchFilter {
  @State filterOptions: string[] = ['位置', '支付方式', '租金', '排序']
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
  @State paymentWays: string[] = ['月付', '季付', '半年付', '年付']
  @State paymentWayText: string = ''
  @State submitPaymentWayText: string = ''
  @State rentPriceList: IRentPriceList = [
    {
      id: 1,
      minRent: '0',
      maxRent: '0',
      text: '不限'
    },
    {
      id: 2,
      minRent: '0',
      maxRent: '1500',
      text: '1500元以下'
    },
    {
      id: 3,
      minRent: '1500',
      maxRent: '2500',
      text: '1500-2500元'
    },
    {
      id: 4,
      minRent: '2500',
      maxRent: '3500',
      text: '2500-3500元'
    },
    {
      id: 5,
      minRent: '3500',
      maxRent: '4500',
      text: '3500-4500元'
    },
    {
      id: 6,
      minRent: '4500',
      maxRent: '6000',
      text: '4500-6000元'
    },
    {
      id: 7,
      minRent: '6000',
      maxRent: '8000',
      text: '6000-8000元'
    },
    {
      id: 8,
      minRent: '8000',
      maxRent: '10000',
      text: '8000-10000元'
    },
    {
      id: 9,
      minRent: '10000',
      maxRent: '0',
      text: '10000元以上'
    }
  ]
  @State rentPriceText: string = ''
  @State submitRentPriceText: string = ''
  @State sortList: ISortList = [
    {
      id: 1,
      icon: $r('app.media.sort'),
      text: '综合排序',
      orderBy: '',
      orderType: ''
    },
    {
      id: 2,
      icon: $r('app.media.rent'),
      text: '价格从低到高',
      orderBy: 'price',
      orderType: 'asc'
    },
    {
      id: 3,
      icon: $r('app.media.rent'),
      text: '价格从高到低',
      orderBy: 'price',
      orderType: 'desc'
    },
    {
      id: 4,
      icon: $r('app.media.area'),
      text: '面积从大到小',
      orderBy: 'area',
      orderType: 'desc'
    },
    {
      id: 5,
      icon: $r('app.media.area'),
      text: '面积从小到大',
      orderBy: 'area',
      orderType: 'asc'
    },
  ]
  @State sortText: string = ''

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
    this.currentFilterText = text
    this.isShowFilterArea = true
    if (text === '位置') {
      this.getProvinceList()
      this.provinceCode = this.submitProvinceCode
      this.cityCode = this.submitCityCode
      this.districtCode = this.submitDistrictCode
    } else if (text === '支付方式') {
      this.paymentWayText = this.submitPaymentWayText
    } else if (text === '租金') {
      this.rentPriceText = this.submitRentPriceText
    }
  }

  hideFilterArea() {
    this.currentFilterText = ''
    this.isShowFilterArea = false
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
    .height(300)
  }

  @Builder
  paymentWayBuilder() {
    Column() {
      Column({ space: 12 }) {
        Text('特殊户型')
          .fontColor($r('app.color.black'))
          .fontSize(12)
        Row({ space: 16 }) {
          ForEach(this.paymentWays, (paymentWay: string) => {
            Text(paymentWay)
              .height(26)
              .backgroundColor(this.paymentWayText == paymentWay ? '#67C0A8' : $r('app.color.bg_gray'))
              .fontColor(this.paymentWayText == paymentWay ? $r('app.color.white') : $r('app.color.gray_second'))
              .fontSize(12)
              .layoutWeight(1)
              .borderRadius(4)
              .textAlign(TextAlign.Center)
              .onClick(() => {
                this.paymentWayText = paymentWay
              })
          }, (paymentWay: string) => paymentWay)
        }

      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .padding(16)

      Row({ space: 22 }) {
        Button('重置')
          .type(ButtonType.Normal)
          .fontSize(12)
          .fontColor($r('app.color.gray_second'))
          .backgroundColor('#F0F0F0')
          .width('30%')
          .borderRadius(4)
          .onClick(() => {
            this.paymentWayText = ''
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
            this.submitPaymentWayText = this.paymentWayText
            globalEmitter.emit('search', {
              paymentType: this.paymentWayText
            })
          })

      }
      .padding(16)
      .width('100%')
      .height(60)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }

  @Builder
  princeBuilder() {
    Column() {
      Grid() {
        ForEach(this.rentPriceList, (rentPrice: IRentPriceItem) => {
          GridItem() {
            Text(rentPrice.text)
              .height(26)
              .width(95)
              .backgroundColor(this.rentPriceText == rentPrice.text ? '#67C0A8' : $r('app.color.bg_gray'))
              .fontColor(this.rentPriceText == rentPrice.text ? $r('app.color.white') : $r('app.color.gray_second'))
              .fontSize(12)
              .layoutWeight(1)
              .borderRadius(4)
              .textAlign(TextAlign.Center)
              .onClick(() => {
                this.rentPriceText = rentPrice.text
              })
          }
        }, (rentPrice: IRentPriceItem) => rentPrice.id + '')
      }
      .height(134)
      .padding(PADDING)
      .columnsTemplate('1fr 1fr 1fr')
      .columnsGap(22)
      .rowsGap(8)

      Row({ space: 22 }) {
        Button('重置')
          .type(ButtonType.Normal)
          .fontSize(12)
          .fontColor($r('app.color.gray_second'))
          .backgroundColor('#F0F0F0')
          .width('30%')
          .borderRadius(4)
          .onClick(() => {
            this.rentPriceText = ''
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
            this.submitRentPriceText = this.rentPriceText
            const rent = this.rentPriceList.find((rentPrice: IRentPriceItem) => rentPrice.text === this.rentPriceText)
            globalEmitter.emit('search', {
              minRent: rent?.minRent,
              maxRent: rent?.maxRent
            })
          })

      }
      .padding(16)
      .width('100%')
      .height(60)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }

  @Builder
  sortBuilder() {
    Column() {
      List() {
        ForEach(this.sortList, (sort: ISortItem) => {
          ListItem() {
            Row({ space: 8 }) {
              Image(sort.icon)
                .width(16)
                .height(16)
                .objectFit(ImageFit.Fill)
              Text(sort.text)
                .height(26)
                .width(95)
                .fontColor(this.sortText == sort.text ? '#36d1a1' : $r('app.color.gray_second'))
                .fontSize(12)
                .textAlign(TextAlign.Start)

            }
            .padding({ left: PADDING, right: PADDING, bottom: PADDING })
            .borderRadius(4)
            .height(34)
            .width('100%')
            .justifyContent(FlexAlign.Start)
            .onClick(() => {
              this.sortText = sort.text
              const curSort = this.sortList.find((sortItem: ISortItem) => sortItem.text === this.sortText)
              globalEmitter.emit('search', {
                orderBy: curSort?.orderBy,
                orderType: curSort?.orderType
              })
              this.hideFilterArea()
            })
          }
        }, (sort: ISortItem) => sort.id + '')
      }
      .width('100%')
      .height('auto')
      .padding({
        left: PADDING,
        top: 8,
        right: PADDING
      })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }

  getPositionName = (text: string) => {
    if (text === '位置') {
      return this.submitDistrictName || text
    } else if (text === '支付方式') {
      return this.submitPaymentWayText || text
    } else if (text === '租金') {
      return this.submitRentPriceText || text
    } else if (text === '排序') {
      return this.sortText || text
    } else {
      return text
    }
  }
  getPositionColor = (text: string) => {
    if (text === '位置') {
      return this.submitDistrictName ? $r('app.color.primary') : '#333333'
    } else if (text === '支付方式') {
      return this.submitPaymentWayText ? $r('app.color.primary') : '#333333'
    } else if (text === '租金') {
      return this.submitRentPriceText ? $r('app.color.primary') : '#333333'
    } else if (text === '排序') {
      return this.sortText ? $r('app.color.primary') : '#333333'
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
          } else if (this.currentFilterText === '支付方式') {
            this.paymentWayBuilder()
          } else if (this.currentFilterText === '租金') {
            this.princeBuilder()
          } else {
            this.sortBuilder()
          }
        }
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