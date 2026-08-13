import { IPhoneParam } from '../Models/LoginData';
import { http } from '../utils/http';

// 获取发现列表数据
export const postPhoneToCodeApi = (data: IPhoneParam): Promise<null> => {
  return http.post<null, IPhoneParam>('/sendSMSCode', data);
}