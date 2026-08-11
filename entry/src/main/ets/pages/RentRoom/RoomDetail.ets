import { getRoomDetailApi } from '../../api/roomDetail';
import { IRoomIdParam } from '../../Models/RentRoomData';

@Component
export default struct RoomDetail {
  pathStack: NavPathStack = new NavPathStack()
  roomId: string = ''
  getRoomDetail = async () => {
    const res = await getRoomDetailApi(this.roomId)
  }

  build() {
    NavDestination() {
      Column() {
        Text("RoomDetail");
      }
    }
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
      const param = context.pathInfo.param as IRoomIdParam
      this.roomId = param.id || 'BJ1827549448671068160'
      this.getRoomDetail()

    })
  }
}