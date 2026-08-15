export interface IPhoneParam {
  phone: string
}

export interface ILoginParam {
  phone: string,
  code: string
}

export interface ILoginResult {
  token: string
}