import { CommonConstants } from '../../common/constants/CommonConstants'
import DateUtil from '../../common/utils/DateUtil'
import DatePickDialog from '../record/DatePickDialog'

@Component
export default struct PanelHeader {
  @StorageProp('selectedDate') selectedDate: number = DateUtil.beginTimeOfDay(new Date())
  private controller: CustomDialogController = new CustomDialogController({
    builder: DatePickDialog({ selectedDate: new Date(this.selectedDate) })
  })
  private title: ResourceStr

  build() {
    Row({ space: CommonConstants.SPACE_2 }) {
      Text(`${DateUtil.formatDateWithoutYear(this.selectedDate)}`)
        .fontSize(16)
        .fontWeight(CommonConstants.FONT_WEIGHT_600)
      Text(this.title)
        .fontSize(16)
        .fontWeight(CommonConstants.FONT_WEIGHT_600)
      Image($r('app.media.ic_public_spinner'))
        .width(25)
        .fillColor(Color.Black)
        .onClick(() => this.controller.open())
    }
  }
}