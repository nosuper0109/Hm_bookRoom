import { http } from '../utils/http'
import type { IHomeData } from '../Models/HomeData'

export const getHomeDataApi = (): Promise<IHomeData> => {
  return http.get<IHomeData>('/home/info')
}