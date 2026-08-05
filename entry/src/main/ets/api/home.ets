import { http } from '../utils/http'
import type { IHomeData, INearbyHousesList } from '../Models/HomeData'

export const getHomeDataApi = (): Promise<IHomeData> => {
  return http.get<IHomeData>('/home/info')
}

export const getNearbyHousesApi = (): Promise<INearbyHousesList> => {
  return http.get<INearbyHousesList>('/house/nearbyHouses')
}