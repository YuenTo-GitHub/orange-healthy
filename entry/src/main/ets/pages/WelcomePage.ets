import router from '@ohos.router'
import common from '@ohos.app.ability.common'
import PreferenceUtil from '../common/utils/PreferenceUtil'
import UserPrivacyDialog from '../view/welcome/UserPrivacyDialog'

@Extend(Text) function opacityWhiteText(opacity: number, fontSize: number = 10) {
  .fontSize(fontSize)
  .opacity(opacity)
  .fontColor(Color.White)
}

const USER_PRIVACY_KEY = 'userPrivacyKey'

@Entry
@Component
struct WelcomePage {

  context = getContext(this) as common.UIAbilityContext
  controller: CustomDialogController = new CustomDialogController({
    builder: UserPrivacyDialog({
      confirm: () => this.onConfirm(),
      cancel: () => this.exitApp()
    })
  })

  onConfirm() {
    PreferenceUtil.putPreferenceValue(USER_PRIVACY_KEY, true)
    this.jumpToIndex()
  }

  exitApp() {
    // 退出App
    this.context.terminateSelf()
  }

  jumpToIndex() {
    setTimeout(()=>{
      router.replaceUrl({
        url: 'pages/Index'
      })
    }, 2000)
  }

  async aboutToAppear() {
    let isAgree = await PreferenceUtil.getPreferenceValue(USER_PRIVACY_KEY, false)
    if (isAgree) {
      this.jumpToIndex()
    } else {
      this.controller.open()
    }
  }

  build() {
    Column() {
      // 中央slogan
      Row() {
        Image($r('app.media.home_slogan')).width(260)
      }
      .layoutWeight(1)
      // logo
      Image($r('app.media.home_logo')).width(150)
      Row() {
        Text('橙子健康支持').opacityWhiteText(0.8, 12)
        Text('IPv6')
          .opacityWhiteText(0.8, 10)
          .border({ style: BorderStyle.Solid, width: 1, color: Color.White, radius: 15 })
          .padding({ left: 3, right: 3 })
          .margin({ left: 2, right: 2 })
        Text('网络').opacityWhiteText(0.8, 12)
      }.margin({top:10,bottom:35})
    }
    .height('100%')
    .width('100%')
    .backgroundColor($r('app.color.welcome_page_background'))
  }
}