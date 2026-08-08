import { http } from '../utils/http';
import type { IGetRentRoomListParams, IGetRentRoomListResponse } from '../Models/RentRoomData';

// 获取租房列表数据
export const getRentRoomListApi = (params: IGetRentRoomListParams): Promise<IGetRentRoomListResponse> => {
  return http.get<IGetRentRoomListResponse, IGetRentRoomListParams>('/house/search', params)
}