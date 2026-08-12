import { getRoomDetailApi } from '../../api/roomDetail';
import { PADDING } from '../../constants/size';
import { IHousePictureList, IRentRoomDetail } from '../../Models/HouseData';
import { IRoomIdParam } from '../../Models/RentRoomData';
import NavBar from '../../views/RoomDetail/NavBar';
import PictureList from '../../views/RoomDetail/PictureList';

@Entry
@Component
export default struct RoomDetail {
  pathStack: NavPathStack = new NavPathStack()
  @State roomData: Partial<IRentRoomDetail> = {}
  @State roomPictureList: IHousePictureList = []
  roomId: string = ''
  getRoomDetail = async () => {
    this.roomData = await getRoomDetailApi(this.roomId)
    this.roomPictureList = this.roomData.housePicture!
  }

  build() {
    NavDestination() {
      Column({ space: PADDING }) {
        NavBar({ title: this.roomData.houseTitle })

        PictureList({ pictureList: this.roomPictureList })
      }
    }
    .hideBackButton(true)
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
      const param = context.pathInfo.param as IRoomIdParam
      this.roomId = param?.id || 'BJ1827549448671068160'
      this.getRoomDetail()

    })
  }
}