@Component
export default struct SafeArea {
  build() {
    Column() {
    }
    .width('100%')
    .height(184)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['#DEFBE5', 0],
        ['#fff', 1],
      ]
    })
  }
}