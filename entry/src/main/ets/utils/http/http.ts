import axios, { InternalAxiosRequestConfig } from '@ohos/axios'
import { promptAction } from '@kit.ArkUI'
import type { AnyObject } from '../../Models/HttpModel'

const request = axios.create({
  baseURL: 'http://192.168.20.15:6060'
})

request.interceptors.request.use(
  (config: InternalAxiosRequestConfig) => {
    const token = AppStorage.get<string>('token') ?? ''
    if (token) {
      // config.headers.set('Authorization', `Bearer ${token}`)
      config.headers.set('token', token)
    }
    return config
  }
)

request.interceptors.response.use(
  (response) => {
    if (response.data?.code == 200) {
      return response.data?.data
    } else {
      promptAction.openToast({ message: response.data?.message })
      return Promise.reject(response.data?.message)
    }
  },
  (error) => {
    promptAction.openToast({ message: error.message })
    return Promise.reject(error.message)
  })

export class Http {
  get<T, K = AnyObject>(url: string, params?: K) {
    return request.get<unknown, T>(url, { params })
  }

  post<T, K>(url: string, data?: K) {
    return request.post<unknown, T>(url, data)
  }

  put<T, K>(url: string, data?: K) {
    return request.put<unknown, T>(url, data)
  }

  delete<T, K = AnyObject>(url: string, params?: K) {
    return request.delete<unknown, T>(url, { params })
  }
}