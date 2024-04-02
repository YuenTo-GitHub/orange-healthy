import DateUtil from '../../common/utils/DateUtil'
import RecordService from '../../service/RecordService'
import RecordVO from '../../viewmodel/RecordVO'
import RecordList from './RecordList'
import SearchHeader from './SearchHeader'
import StatisticCard from './StatisticCard'

@Component
export default struct RecordIndex {
  @Provide records: RecordVO[] = []
  @Prop @Watch('handlePageShow') isPageShow: boolean
  @StorageProp('selectedDate') @Watch('aboutToAppear') selectedDate: number = DateUtil.beginTimeOfDay(new Date())

  async aboutToAppear() {
    this.records = await RecordService.queryRecordByDate(this.selectedDate)
  }

  handlePageShow() {
    if (this.isPageShow) {
      this.aboutToAppear()
    }
  }

  build() {
    Column() {
      // 搜索框
      SearchHeader()
      // 统计卡片
      StatisticCard()
      // 记录列表
      RecordList()
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.index_page_background'))
  }
}