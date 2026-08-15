import { ILoginParam, ILoginResult, IPhoneParam } from '../Models/LoginData';
import { IUserInfo } from '../Models/UserData';
import { http } from '../utils/http';

// 获取发现列表数据
export const postPhoneToCodeApi = (data: IPhoneParam): Promise<null> => {
  return http.post<null, IPhoneParam>('/sendSMSCode', data);
}

// 登录
export const loginApi = (phone: string, code: string): Promise<ILoginResult> => {
  return http.post<ILoginResult, ILoginParam>('/login', { phone, code })
}

// 获取用户数据
export const getUserInfoApi = (): Promise<IUserInfo> => {
  return http.get<IUserInfo>('/auth/user/userInfo')
}