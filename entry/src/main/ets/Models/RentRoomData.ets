import type { INearbyHousesItem } from './HomeData'

export type IPaymentType = "月付" | "季付" | "半年付" | "年付" | ""

export type IOrderBy = "area" | "price" | ""

export type IOrderType = "asc" | "desc" | ""

export interface IGetRentRoomListParams {
  "page": number
  "limit": number
  "provinceCode"?: string
  "cityCode"?: string
  "districtCode"?: string
  "minRent"?: string
  "maxRent"?: string
  "paymentType"?: IPaymentType
  "orderBy"?: IOrderBy,
  "orderType"?: IOrderType
}

export interface IGetRentRoomListResponse {
  records: IRentRoomList
  total: number
}

export interface IActivity {
  "title": string
  "textColor": string
  "textBackGroundColor": string
  "#text": string
  "icon": string
}

export interface IRentRoomItem extends INearbyHousesItem {
  "activity"?: IActivity
}

export type IRentRoomList = IRentRoomItem[]

export interface IProvinceItem {
  code: string;
  name: string;
}

export type IProvinceList = IProvinceItem[]

export interface ICityItem {
  "code": string
  "name": string
  "provinceCode": string
}

export type ICityList = ICityItem[]

export interface IDistrictItem {
  "code": string
  "name": string
  "cityCode": string
  "provinceCode": string
}

export type IDistrictList = IDistrictItem[]

export interface GetCityListParams {
  provinceCode: string
}

export interface GetDistrictListParams {
  cityCode: string
}

export interface IRentPriceItem {
  id: number,
  minRent: string,
  maxRent: string,
  text: string
}

export type IRentPriceList = IRentPriceItem[]

export interface ISortItem {
  id: number;
  icon: Resource | string;
  text: string;
  orderBy: IOrderBy;
  orderType: IOrderType;
}

export type ISortList = ISortItem[]