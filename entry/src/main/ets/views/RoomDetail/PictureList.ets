import { PADDING } from '../../constants/size';
import { IHousePictureItem, IHousePictureList } from '../../Models/HouseData';

@Component
export default struct PictureList {
  @Prop @Watch('onPictureListChange') pictureList: IHousePictureList
  @State nameList: string[] = []
  @State pictures: string[] = []
  @State currentName: string = ''
  nameListScroller: Scroller = new Scroller()
  picturesScroller: Scroller = new Scroller()
  @State stopIndex: number = 0

  onPictureListChange() {
    this.nameList = this.pictureList.map((item: IHousePictureItem) => {
      return item.spaceName
    })

    this.pictures = this.pictureList.reduce((p: string[], c) => {
      return p.concat(c.picList)
    }, [])

    this.currentName = this.pictureList[0].spaceName
  }

  build() {
    Column() {
      List({ space: 16, scroller: this.nameListScroller }) {
        ForEach(this.nameList, (name: string, index: number) => {
          ListItem() {
            Column({ space: 4 }) {
              Text(`${name}(${this.pictureList[index].picList.length ?? 0})`)
                .fontColor(this.currentName === name ? $r('app.color.black') : $r('app.color.gray_second'))
              if (this.currentName === name) {
                Divider()
                  .strokeWidth(2)
                  .width(16)
                  .color('#36D1A1')
              }
            }
            .height(30)
            .onClick(() => {
              this.currentName = name
              const targetIndex = this.pictureList.reduce((p, c, i) => {
                if (i < index) {
                  return p + c.picList.length
                }
                return p
              }, 0)
              this.picturesScroller.scrollToIndex(targetIndex, true)
            })
          }
        })
      }
      .listDirection(Axis.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
      .height(36)
      .contentEndOffset(16)

      List({ space: 16, scroller: this.picturesScroller }) {
        ForEach(this.pictures, (picture: string) => {
          ListItem() {
            Image(picture)
              .width(318)
              .height('100%')
              .objectFit(ImageFit.Fill)
          }
        })
      }
      .scrollSnapAlign(ScrollSnapAlign.START)
      .listDirection(Axis.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
      .height(192)
      .contentEndOffset(16)
      .onScrollIndex((start: number) => {
        this.stopIndex = start
      })
      .onScrollStop(() => {
        let idx: number = this.stopIndex
        const nameTarget = this.pictureList.findIndex((item: IHousePictureItem) => {
          if (idx < item.picList.length) {
            return true
          } else {
            idx -= item.picList.length
            return false
          }
        })
        this.nameListScroller.scrollToIndex(nameTarget, true)
        this.currentName = this.pictureList[nameTarget].spaceName
      })
    }
    .padding({ left: PADDING })
  }
}