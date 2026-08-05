import { IColor } from '../../Models/HomeData'

@Component
export default struct Index {
  scrollHeight: number = 0
  @State bg_color: string = 'rgba(255, 255, 255, 0)'
  @State font_color: string = 'rgb(255, 255, 255)'
  @BuilderParam navBuilderParam: ($$: IColor) => void = this.customBuilder
  @BuilderParam contentBuilderParam: () => void = this.customBuilder

  @Builder
  customBuilder() {
  }

  calcColor = () => {
    if (this.scrollHeight < 10) {
      this.font_color = 'rgb(255, 255, 255)'
      this.bg_color = 'rgba(255, 255, 255, 0)'
    } else if (this.scrollHeight <= 100) {
      const colorOpacity = (this.scrollHeight - 10) / (100 - 10)
      this.bg_color = `rgba(255, 255, 255, ${colorOpacity})`
      this.font_color = `rgba(0, 0, 0, ${colorOpacity})`
    } else {
      this.bg_color = `rgb(255, 255, 255)`
      this.font_color = `rgb(0, 0, 0,)`
    }
  }
  scrollHandler = (xOffset: number, yOffset: number) => {
    this.scrollHeight += yOffset

    this.calcColor()
  }

  build() {
    Stack() {
      Scroll() {
        Column() {
          this.contentBuilderParam()
        }
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
      .align(Alignment.TopStart)
      .width("100%")
      .height("100%")
      .onDidScroll(this.scrollHandler)

      this.navBuilderParam({ font_color: this.font_color, bg_color: this.bg_color })
    }
    .width('100%')
    .alignContent(Alignment.Top)
  }
}