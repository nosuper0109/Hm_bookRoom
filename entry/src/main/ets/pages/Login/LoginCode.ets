import { postPhoneToCodeApi } from '../../api/login';
import { IPhoneParam } from '../../Models/LoginData';
import LoginCodeFrom from '../../views/Login/LoginCodeFrom';
import NavBar from '../../views/Login/NavBar';
import SafeArea from '../../views/Login/SafeArea';

@Builder
function LoginCodeBuilder() {
  LoginCode()
}

@Entry
@Component
struct LoginCode {
  @Consume('navPathStack') pathStack: NavPathStack = new NavPathStack()
  phone: string = ''
  postPhone = async () => {
    const param: IPhoneParam = this.pathStack.getParamByName('LoginCode')[0] as IPhoneParam
    this.phone = param.phone
    await postPhoneToCodeApi(param)
  }

  aboutToAppear(): void {
    this.postPhone()
  }

  build() {
    NavDestination() {
      Stack() {
        SafeArea()
        Column() {
          NavBar()

          LoginCodeFrom({phone: this.phone})
        }
      }
      .alignContent(Alignment.Top)
      .width('100%')
    }
    .hideBackButton(true)
  }
}