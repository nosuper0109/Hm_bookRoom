import NavBar from '../../views/RentRoom/NavBar';
import RoomList from '../../views/RentRoom/RoomList';
import SearchFilter from '../../views/RentRoom/SearchFilter';

@Builder
export function RentRoomListBuilder() {
  RentRoomList()
}

@Component
export default struct RentRoomList {
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;

  build() {
    NavDestination() {
      Stack() {
        RoomList()
        SearchFilter()
        NavBar()
          .backgroundColor($r('app.color.white'))
      }
      .width('100%')
      .height('100%')
      .alignContent(Alignment.TopStart)
    }
    .padding({ top: this.getUIContext().px2vp(this.topRectHeight) })
    .hideTitleBar(true)
  }
}
