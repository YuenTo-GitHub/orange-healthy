import router from '@ohos.router'
import { CommonConstants } from '../constants/CommonConstants'

@Component
export default struct Header {
  title: ResourceStr

  build() {
    Row() {
      Image($r('app.media.ic_public_back'))
        .width(20)
        .onClick(() => router.back())
      Blank()
      Text(this.title).fontSize(18).fontWeight(CommonConstants.FONT_WEIGHT_600)
      Blank()
    }
    .height(30)
    .margin({ top: 5 })
    .alignItems(VerticalAlign.Center)
    .width(CommonConstants.THOUSANDTH_940)
  }
}