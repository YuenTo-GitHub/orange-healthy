import { CommonConstants } from '../../common/constants/CommonConstants'

@Component
export default struct NutrientStatistic {
  @Prop carbon: number
  @Prop protein: number
  @Prop fat: number
  recommendCarbon: number = CommonConstants.RECOMMEND_CARBON
  recommendProtein: number = CommonConstants.RECOMMEND_PROTEIN
  recommendFat: number = CommonConstants.RECOMMEND_FAT

  build() {
    Row({ space: CommonConstants.SPACE_6 }) {
      // 碳水
      this.StatsBuilder({
        label: '碳水化合物',
        value: this.carbon,
        recommend: this.recommendCarbon,
        progressColor: $r('app.color.carbon_color')
      })

      // 蛋白质
      this.StatsBuilder({
        label: '蛋白质',
        value: this.protein,
        recommend: this.recommendProtein,
        progressColor: $r('app.color.protein_color')
      })
      // 脂肪
      this.StatsBuilder({
        label: '脂肪',
        value: this.fat,
        recommend: this.recommendFat,
        progressColor: $r('app.color.fat_color')
      })
    }
    .width('100%')
    .padding({ top: 30, bottom: 35 })
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  @Builder StatsBuilder($$: {
    label: string,
    value: number,
    recommend: number,
    progressColor: ResourceStr
  }) {
    Column({ space: CommonConstants.SPACE_6 }) {
      Stack() {
        // 进度条
        Progress({
          value: $$.value,
          total: $$.recommend,
          type: ProgressType.Ring
        })
          .width(95)
          .style({ strokeWidth: CommonConstants.DEFAULT_6 })
          .color($$.progressColor)
        Column({ space: CommonConstants.SPACE_4 }) {
          Text('摄入推荐')
            .fontSize(12)
            .fontColor($r('app.color.gray'))
            .fontWeight(CommonConstants.FONT_WEIGHT_600)
          Text(`${$$.value}/${$$.recommend}`)
            .fontSize(18)
            .fontWeight(CommonConstants.FONT_WEIGHT_700)
        }
      }

      Text(`${$$.label}（克）`)
        .fontSize(12)
        .fontColor($r('app.color.light_gray'))
    }
  }
}