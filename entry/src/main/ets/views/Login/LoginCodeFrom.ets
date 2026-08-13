import { postPhoneToCodeApi } from '../../api/login';
import { PADDING } from '../../constants/size';

@Component
export default struct LoginCodeForm {
  START_TIME: number = 60
  @State time: number = this.START_TIME
  @Prop phone: string = ''
  countDown = () => {
    const timer = setInterval(() => {
      if (this.time === 0) {
        clearInterval(timer)
        return
      }
      this.time--
    }, 1000)
  }
  postPhone = async () => {
    this.time = this.START_TIME
    await postPhoneToCodeApi({ phone: this.phone })
    this.countDown()
  }

  aboutToAppear(): void {
    this.countDown()
  }

  onPageHide(): void {
    this.time = 0
  }

  aboutToDisappear(): void {
    this.time = 0
  }

  build() {
    Column() {
      Stack() {
        TextInput({ placeholder: '请输入验证码' })
          .placeholderColor('#c1c1c1')
          .padding({ left: 0 })
          .backgroundColor(Color.Transparent)
          .borderRadius(0)
          .type(InputType.PhoneNumber)
          .border({
            width: { bottom: 1 },
            color: '#C4EDCE'
          })
          .maxLength(6)

        Text(this.time == 0 ? '重发' : this.time + '')
          .fontSize(16)
          .fontColor('#36D1A1')
          .margin({ right: 10 })
          .onClick(() => {
            if (this.time == 0) {
              this.postPhone()
            }

          })


      }
      .alignContent(Alignment.End)
      .margin({ top: 46, bottom: PADDING })

      Row() {
        Button('确定')
          .backgroundColor('#36D1A1')
          .fontColor('#FFFFFF')
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
      .margin({ top: 40 })

    }
    .width('100%')
    .padding({ left: 38, right: 38 })
  }
}