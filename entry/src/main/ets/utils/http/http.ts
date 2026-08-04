import axios from '@ohos/axios'
import { promptAction } from '@kit.ArkUI'
import type { AnyObject } from '../../Models/HttpModel'

const request = axios.create({
  baseURL: 'http://192.168.20.15:6060'
})

request.interceptors.request.use(
  (config) => {
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
  get<T>(url: string, params?: AnyObject) {
    return request.get<unknown, T>(url, { params })
  }

  post<T>(url: string, data?: AnyObject) {
    return request.post<unknown, T>(url, data)
  }

  put<T>(url: string, data?: AnyObject) {
    return request.put<unknown, T>(url, data)
  }

  delete<T>(url: string, params?: AnyObject) {
    return request.delete<unknown, T>(url, { params })
  }
}