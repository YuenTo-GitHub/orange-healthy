import { CommonConstants } from '../../common/constants/CommonConstants'

@CustomDialog
export default struct DatePickDialog {
  controller: CustomDialogController
  selectedDate: Date

  build() {
    Column({ space: CommonConstants.SPACE_12 }) {
      DatePicker({
        start: new Date('2022-01-01'),
        end: new Date(),
        selected: this.selectedDate
      })
        .onChange((date: DatePickerResult) => {
          this.selectedDate.setFullYear(date.year, date.month, date.day)
        })
      Row({ space: CommonConstants.SPACE_12 }) {
        Button('取消')
          .width(120)
          .backgroundColor($r('app.color.light_gray'))
          .onClick(() => {
            this.controller.close()
          })
        Button('确定')
          .width(120)
          .backgroundColor($r('app.color.primary_color'))
          .onClick(() => {
            // 保存日期到全局存储
            AppStorage.SetOrCreate('selectedDate', this.selectedDate.getTime())
            // 关闭窗口
            this.controller.close()
          })
      }
    }
    .padding(CommonConstants.SPACE_10)
  }
}