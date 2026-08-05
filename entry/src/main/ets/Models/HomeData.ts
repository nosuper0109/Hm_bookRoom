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
  title: string
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

export interface ITagsItem {
  name: string
}

export type ITagsList = ITagsItem[]

export interface INearbyHousesItem {
  "id": string,
  "housePicture": string,
  "tags": ITagsList,
  "houseTitle": string,
  "address": string,
  "rentPriceUnit": string,
  "rentPriceListing": string,
  "rentArea": string
}

export type INearbyHousesList = INearbyHousesItem[]

export interface IColor {
  font_color: string
  bg_color: string
}