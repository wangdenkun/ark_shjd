import axios from '@ohos/axios'

const baseUrl = 'http://192.168.4.106:3000'

// todo: 后期可做接口路径的拆分
class ApiPath {
  static hotelList = `${baseUrl}/hotelList`
}
export class Api {

  static getHotelList() {
    return axios.get(ApiPath.hotelList,{
      connectTimeout: 2000
    })
  }
}