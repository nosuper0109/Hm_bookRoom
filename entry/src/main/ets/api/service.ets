import { http } from '../utils/http'
import { IServiceData } from '../Models/ServiceData'

export const getServiceDataApi = (): Promise<IServiceData> => {
  return http.get<IServiceData>('/service/info')
}
