import axios, { InternalAxiosRequestConfig, AxiosResponse, AxiosError, AxiosInstance } from '@ohos/axios';
import { promptAction } from '@kit.ArkUI';
import BuildProfile from 'entry/BuildProfile';

interface ApiResponse<T = Object> {
  code: number
  message: string
  data: T
}

class Request {
  private instance: AxiosInstance = axios.create({
    baseURL: BuildProfile.baseURL
  })

  constructor() {
    this.setupRequestInterceptor()
    this.setupResponseInterceptor()
  }

  private setupRequestInterceptor() {
    this.instance.interceptors.request.use((config: InternalAxiosRequestConfig) => {
      const token = AppStorage.get<string>('token') ?? ''
      if (token) {
        config.headers.set('token', token)
      }
      return config
    }, (error: AxiosError) => {
      return Promise.reject(error)
    })
  }

  private setupResponseInterceptor() {
    this.instance.interceptors.response.use((response: AxiosResponse) => {
      return response
    }, (error: AxiosError) => {
      promptAction.openToast({ message: error.message ?? '' })
      return Promise.reject(error)
    })
  }

  private handleResponse<T>(response: AxiosResponse): Promise<T> {
    const res = response.data as ApiResponse<T>
    if (res.code == 200) {
      return Promise.resolve(res.data)
    } else {
      promptAction.openToast({ message: res.message ?? '' })
      return Promise.reject(res.message ?? '')
    }
  }

  get<T>(url: string, params?: Object): Promise<T> {
    return this.instance.get<ApiResponse<T>>(url, { params }).then((response: AxiosResponse<ApiResponse<T>>) => {
      return this.handleResponse<T>(response)
    })
  }

  post<T>(url: string, data?: Object): Promise<T> {
    return this.instance.post<ApiResponse<T>>(url, data).then((response: AxiosResponse<ApiResponse<T>>) => {
      return this.handleResponse<T>(response)
    })
  }

  put<T>(url: string, data?: Object): Promise<T> {
    return this.instance.put<ApiResponse<T>>(url, data).then((response: AxiosResponse<ApiResponse<T>>) => {
      return this.handleResponse<T>(response)
    })
  }

  delete<T>(url: string, params?: Object): Promise<T> {
    return this.instance.delete<ApiResponse<T>>(url, { params }).then((response: AxiosResponse<ApiResponse<T>>) => {
      return this.handleResponse<T>(response)
    })
  }
}

export const http = new Request()
