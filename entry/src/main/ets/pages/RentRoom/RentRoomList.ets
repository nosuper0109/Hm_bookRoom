import NavBar from '../../views/RentRoom/NavBar';
import RoomList from '../../views/RentRoom/RoomList';
import SearchFilter from '../../views/RentRoom/SearchFilter';

@Builder
export function RentRoomListBuilder() {
  RentRoomList()
}

@Preview
@Component
export default struct RentRoomList {
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;

  build() {
    NavDestination() {
      Column() {
        NavBar()

        SearchFilter()

        RoomList()
          .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Start)
    }
    .padding({ top: this.getUIContext().px2vp(this.topRectHeight) })
    .hideTitleBar(true)
  }
}
