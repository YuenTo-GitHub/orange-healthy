import DatePickDialog from './DatePickDialog'
import DateUtil from '../../common/utils/DateUtil'
import { CommonConstants } from '../../common/constants/CommonConstants'
import CalorieStatistic from './CalorieStatistic'
import NutrientStatistic from './NutrientStatistic'
import RecordList from './RecordList'
import BreakpointConstants from '../../common/constants/BreakpointConstants'
import RecordVO from '../../viewmodel/RecordVO'
import StatsInfo from '../../viewmodel/StatsInfo'
import RecordService from '../../service/RecordService'

@Component
export default struct StatisticCard {
  @Consume @Watch('handleRecordsChange') records: RecordVO[]
  @State info: StatsInfo = new StatsInfo()
  @StorageProp('selectedDate') selectedDate: number = DateUtil.beginTimeOfDay(new Date())
  @StorageProp('currentBreakpoint') currentBreakPoint: string = BreakpointConstants.BREAKPOINT_SM
  private swiperDisplayParams: [number, boolean, boolean]
  private controller: CustomDialogController = new CustomDialogController({
    builder: DatePickDialog({ selectedDate: new Date(this.selectedDate) })
  })

  handleRecordsChange(){
    this.info = RecordService.calculateStatsInfo(this.records)
  }

  aboutToAppear() {
    // Swiper组件显示参数，分别为displayCount、indicator和disableSwiper
    if (this.currentBreakPoint == BreakpointConstants.BREAKPOINT_LG) {
      this.swiperDisplayParams = [2, false, true]
    } else {
      this.swiperDisplayParams = [1, true, false]
    }
  }

  build() {
    Column() {
      // 日期信息
      Row() {
        Text(DateUtil.formatDateWithYear(this.selectedDate))
          .fontColor($r('app.color.secondary_color'))
        Image($r('app.media.ic_public_spinner'))
          .width(25)
          .fillColor($r('app.color.secondary_color'))
      }
      .margin({ left: 50 })
      .justifyContent(FlexAlign.Start)
      .padding(CommonConstants.SPACE_2)
      .onClick(() => this.controller.open())
      .width(CommonConstants.THOUSANDTH_1000)
      // 统计信息
      Swiper() {
        // 热量统计
        CalorieStatistic({ intake: this.info.intake, consumption: this.info.consumption })
        // 营养素统计
        NutrientStatistic({ carbon: this.info.carbon, protein: this.info.protein, fat: this.info.fat })
      }
      .backgroundColor(Color.White)
      .indicator(this.swiperDisplayParams[1])
      .width(CommonConstants.THOUSANDTH_1000)
      .borderRadius(CommonConstants.DEFAULT_18)
      .displayCount(this.swiperDisplayParams[0])
      .disableSwipe(this.swiperDisplayParams[2])
      .indicatorStyle({ selectedColor: $r('app.color.primary_color') })
    }
    .width(CommonConstants.THOUSANDTH_940)
    .backgroundColor($r('app.color.lightest_primary_color'))
    .borderRadius(CommonConstants.DEFAULT_18)
  }
}