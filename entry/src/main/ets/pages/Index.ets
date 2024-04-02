import BreakpointConstants from '../common/constants/BreakpointConstants'
import { CommonConstants } from '../common/constants/CommonConstants'
import BreakpointSystem from '../common/utils/BreakpointSystem'
import RecordIndex from '../view/record/Index'

@Entry
@Component
struct Index {
  @StorageProp('currentBreakpoint') currentBreakPoint: string = BreakpointConstants.BREAKPOINT_SM
  private breakPointSys: BreakpointSystem = new BreakpointSystem()
  private barPosition: BarPosition
  private vertical: boolean
  @State currentTabIndex: number = 0
  @State isPageShow: boolean = false

  @Builder TabBarBuilder(title: ResourceStr, image: ResourceStr, index: number) {
    Column({ space: CommonConstants.SPACE_8 }) {
      Image(image)
        .width(22)
        .fillColor(this.setTabColor(index))
      Text(title)
        .fontSize(14)
        .fontColor(this.setTabColor(index))
    }
  }

  aboutToAppear() {
    this.breakPointSys.register()
    this.barPosition = BreakpointConstants.BAR_POSITION.getValue(this.currentBreakPoint)
    this.vertical = BreakpointConstants.BAR_VERTICAL.getValue(this.currentBreakPoint)
  }

  aboutToDisappear() {
    this.breakPointSys.unregister()
  }

  onPageShow(){
    this.isPageShow = true
  }

  onPageHide(){
    this.isPageShow = false
  }

  setTabColor(index: number): ResourceColor {
    return this.currentTabIndex === index ? $r('app.color.primary_color') : $r('app.color.gray')
  }

  build() {
    Tabs({ barPosition: this.barPosition }) {
      TabContent() {
        // 记录
        RecordIndex({isPageShow: this.isPageShow})
      }.tabBar(this.TabBarBuilder($r('app.string.tab_record'), $r('app.media.ic_calendar'), 0))

      TabContent() {
        // 发现
      }.tabBar(this.TabBarBuilder($r('app.string.tab_discover'), $r('app.media.discover'), 1))

      TabContent() {
        // 我的
      }.tabBar(this.TabBarBuilder($r('app.string.tab_user'), $r('app.media.ic_user_portrait'), 2))
    }
    .width('100%')
    .height('100%')
    .onChange(index => this.currentTabIndex = index)
    .vertical(this.vertical)
  }
}