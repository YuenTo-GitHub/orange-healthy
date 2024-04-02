import { CommonConstants } from '../../common/constants/CommonConstants'
import RecordItem from '../../viewmodel/RecordItem'

@Component
export default struct ItemCard {
  @Prop amountStr: string
  @Link item: RecordItem

  @Builder NutrientInfo($$: {
    label: string,
    value: number
  }) {
    Column({ space: CommonConstants.SPACE_8 }) {
      Text($$.label).fontSize(14).fontColor($r('app.color.light_gray'))
      Text(($$.value * Number(this.amountStr)).toFixed(1)).fontSize(18).fontWeight(CommonConstants.FONT_WEIGHT_700)
    }
  }

  build() {
    Column({ space: CommonConstants.SPACE_10 }) {
      // 图片
      Image(this.item.image)
        .width(150)
      // 名称
      Row() {
        Text(this.item.name).fontWeight(CommonConstants.FONT_WEIGHT_700)
      }.backgroundColor($r('app.color.lightest_primary_color'))
      .padding({ top: 5, bottom: 5, left: 10, right: 10 })
      .borderRadius(15)

      Divider()
        .width(CommonConstants.THOUSANDTH_940).opacity(0.5)
      // 营养素信息
      Row() {
        this.NutrientInfo({ label: '热量（千卡）', value: this.item.calorie })
        if (this.item.id < 10000) {
          this.NutrientInfo({ label: '碳水（克）', value: this.item.carbon })
          this.NutrientInfo({ label: '蛋白质（克）', value: this.item.protein })
          this.NutrientInfo({ label: '脂肪（克）', value: this.item.fat })
        }
      }.width(CommonConstants.THOUSANDTH_940)
      .justifyContent(FlexAlign.SpaceEvenly)

      Divider()
        .width(CommonConstants.THOUSANDTH_940).opacity(0.5)

      // 份数
      Row() {
        Column({ space: CommonConstants.SPACE_2 }) {
          Text(this.amountStr)
            .fontSize(50).fontColor($r("app.color.primary_color"))
            .fontWeight(CommonConstants.FONT_WEIGHT_600)
          Divider()
            .strokeWidth(2)
            .color($r("app.color.primary_color"))
        }.width(120)

        Text(this.item.unit)
          .fontColor($r("app.color.light_gray"))
          .fontWeight(CommonConstants.FONT_WEIGHT_600)
      }
    }
  }
}