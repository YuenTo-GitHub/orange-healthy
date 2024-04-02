import { CommonConstants } from '../../common/constants/CommonConstants'

@Component
export default struct CalorieStatistic {
  // TODO 摄入量和消耗量计算
  @Prop intake: number
  @Prop consumption: number
  // TODO 推荐值计算
  recommend: number = CommonConstants.RECOMMEND_CALORIE

  remainCalorie(): number {
    let remainCalorie = this.recommend - this.intake + this.consumption
    if (remainCalorie < 0) {
      return 0
    }
    return remainCalorie
  }

  build() {
    Row({ space: CommonConstants.SPACE_6 }) {
      // 饮食摄入
      this.StatsBuilder({ label: '饮食摄入', value: this.intake })

      // 还可以吃
      Stack() {
        // 进度条
        Progress({
          value: this.intake,
          total: this.recommend,
          type: ProgressType.Ring
        })
          .width(120)
          .style({ strokeWidth: CommonConstants.DEFAULT_10 })
          .color($r('app.color.primary_color'))
        this.StatsBuilder({ label: '还可以吃', value: this.remainCalorie(), tips: `推荐${this.recommend}` })
      }

      // 运动消耗
      this.StatsBuilder({ label: '运动消耗', value: this.consumption })
    }
    .width('100%')
    .padding({ top: 30, bottom: 35 })
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  @Builder StatsBuilder($$: {
    label: string,
    value: number,
    tips?: string
  }) {
    Column({ space: CommonConstants.SPACE_6 }) {
      Text($$.label)
        .fontColor($r('app.color.gray'))
        .fontWeight(CommonConstants.FONT_WEIGHT_600)
      Text($$.value.toFixed(0))
        .fontSize(20)
        .fontWeight(CommonConstants.FONT_WEIGHT_700)
      if ($$.tips) {
        Text($$.tips)
          .fontSize(12)
          .fontColor($r('app.color.light_gray'))
      }
    }
  }
}