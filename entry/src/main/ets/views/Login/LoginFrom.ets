import { PADDING } from '../../constants/size';
import { IPhoneParam } from '../../Models/LoginData';

@Component
export default struct LoginFrom {
  @State isEnable: boolean = false
  @State @Watch('enableComputed') isAgree: boolean = false
  @State @Watch('enableComputed') isFormat: boolean = false
  @State phone: string = ''
  @Consume('navPathStack') pathStack: NavPathStack = new NavPathStack()

  enableComputed() {
    this.isEnable = this.isAgree && this.isFormat
  }

  build() {
    Column() {
      Stack() {
        TextInput({ placeholder: '请输入手机号' })
          .placeholderColor('#c1c1c1')
          .padding({ left: 0 })
          .backgroundColor(Color.Transparent)
          .borderRadius(0)
          .type(InputType.PhoneNumber)
          .border({
            width: { bottom: 1 },
            color: '#C4EDCE'
          })
          .maxLength(11)
          .onChange((value: string) => {
            this.phone = value
            if (this.isValidPhone(value)) {
              this.isFormat = true
            } else {
              this.isFormat = false
            }
          })
        if (this.isFormat) {
          Image($r('app.media.success'))
            .width(12)
            .height(8)
            .margin({ right: 5 })
        }
      }
      .alignContent(Alignment.End)
      .margin({ top: 46, bottom: PADDING })

      Row({ space: 6 }) {
        Image(this.isAgree ? $r('app.media.radio_active') : $r('app.media.radio'))
          .width(14)
          .height(14)
          .objectFit(ImageFit.Fill)
          .onClick(() => {
            this.isAgree = !this.isAgree
          })
        Text() {
          Span('同意')
          Span('《用户协议》')
            .fontColor('#36D1A1')
          Span('和')
          Span('《隐私政策》')
            .fontColor('#36D1A1')
        }
        .fontSize(12)
        .fontColor('#C1C1C1')

      }
      .width('100%')
      .justifyContent(FlexAlign.Start)

      Row() {
        Button('获取验证码')
          .backgroundColor(this.isEnable ? '#36D1A1' : '#E0E0E0')
          .fontColor(this.isEnable ? '#FFFFFF' : '#616161')
          .enabled(this.isEnable)
          .onClick(() => {
            const param: IPhoneParam = { phone: this.phone }
            this.pathStack.pushPathByName('LoginCode', param)
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
      .margin({ top: 40 })

    }
    .width('100%')
    .padding({ left: 38, right: 38 })
  }

  private isValidPhone(phone: string): boolean {
    const reg = new RegExp('^1[3-9]\\d{9}$')
    return reg.test(phone)
  }
}