import type { INearbyHousesItem } from './HomeData'

export type IPaymentType = "月付" | "季付" | "半年付" | "年付"

export type IOrderBy = "面积" | "价格"

export type IOrderType = "asc" | "desc"

export interface IGetRentRoomListParams {
  "page": number
  "limit": number
  "provinceId"?: string
  "cityId"?: string
  "districtId"?: string
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