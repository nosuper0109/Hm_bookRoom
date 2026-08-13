import LoginFrom from '../../views/Login/LoginFrom';
import NavBar from '../../views/Login/NavBar';
import SafeArea from '../../views/Login/SafeArea';

@Builder
function LoginPhoneBuilder() {
  LoginPhone()
}

@Entry
@Component
struct LoginPhone {
  build() {
    NavDestination() {
      Stack() {
        SafeArea()
        Column() {
          NavBar()

          LoginFrom()
        }
      }
      .alignContent(Alignment.Top)
      .width('100%')
    }
    .hideBackButton(true)
  }
}