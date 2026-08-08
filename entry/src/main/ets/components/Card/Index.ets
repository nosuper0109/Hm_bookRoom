@Component
export default struct Index {
  @Prop cardPadding: number = 8
  @BuilderParam
  customBuilderParam: () => void = this.customBuilder

  @Builder
  customBuilder() {
  }

  build() {
    Column() {
      this.customBuilderParam()
    }
    .backgroundColor($r('app.color.white'))
    .padding(this.cardPadding)
    .borderRadius(8)
  }
}