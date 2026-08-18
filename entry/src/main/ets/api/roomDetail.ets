import { http } from '../utils/http'
import { IRoomIdParam } from '../Models/RentRoomData'
import { IRentRoomDetail } from '../Models/HouseData'

export const getRoomDetailApi = (id: string): Promise<IRentRoomDetail> => {
  const params: IRoomIdParam = { id }
  return http.get<IRentRoomDetail>('/house/detail', params)
}
