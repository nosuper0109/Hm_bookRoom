export interface IHomeData {
  bannerList: IBannerList
  navList: INavList
  tileList: ITileList
  planList: IPlanList
  adPicture: string
}

export interface IBannerItem {
  id: string
  name: string
  imageURL: string
}

export type IBannerList = IBannerItem[]

export interface INavItem {
  id: string
  name: string
  imageURL: string
}

export type INavList = INavItem[]

export interface ITileItem {
  id: string
  title: string
  sub_title: string
  imageURL: string
}

export type ITileList = ITileItem[]

export interface IPlanItem {
  id: string
  imageURL: string
}

export type IPlanList = IPlanItem[]