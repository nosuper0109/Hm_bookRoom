import { loginApi, postPhoneToCodeApi } from '../../api/login';
import { PADDING } from '../../constants/size';

@Component
export default struct LoginCodeForm {
  START_TIME: number = 60
  @State time: number = this.START_TIME
  @Prop phone: string = ''
  @State code: string = ''
  @StorageLink('token') token: string = ''
  @Consume('navPathStack') pathStack: NavPathStack = new NavPathStack()
  @StorageLink('CurrentActiveIndex') currentActiveIndex: number = 0
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

  // 登录
  async login() {
    try {
      const res = await loginApi(this.phone, this.code);
      // 持久化存储 token
      this.token = res.token
      this.currentActiveIndex = 4
      this.pathStack.clear()
    } catch {
      this.getUIContext().getPromptAction().showToast({ message: '验证码错误' })
    }
  }

  build() {
    Column() {
      Stack() {
        TextInput({ placeholder: '请输入验证码', text: $$this.code })
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
          .backgroundColor(this.code.length == 6 ? '#36D1A1' : '#E0E0E0')
          .fontColor(this.code.length == 6 ? '#FFFFFF' : '#616161')
          .enabled(this.code.length == 6)
          .onClick(() => {
            this.login()
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
      .margin({ top: 40 })

    }
    .width('100%')
    .padding({ left: 38, right: 38 })
  }
}