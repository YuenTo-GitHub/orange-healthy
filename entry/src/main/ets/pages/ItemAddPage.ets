import router from '@ohos.router'
import Header from '../common/component/Header'
import NumberKeyboard from '../common/component/NumberKeyboard'
import { CommonConstants } from '../common/constants/CommonConstants'
import { RecordTypeEnum, RecordTypes } from '../model/RecordTypeModel'
import RecordService from '../service/RecordService'
import ItemCard from '../view/item/ItemCard'
import ItemList from '../view/item/ItemList'
import PanelHeader from '../view/item/PanelHeader'
import RecordItem from '../viewmodel/RecordItem'
import RecordType from '../viewmodel/RecordType'

@Entry
@Component
struct ItemAddPage {
  @State amount: number = 1
  @State showPanel: boolean = false
  @State amountStr: string = '1'
  @State item: RecordItem = null
  @State type: RecordType = RecordTypes[0]
  @State isFood: boolean = true

  onPanelShow(item: RecordItem) {
    this.amount = 1
    this.item = item
    this.amountStr = '1'
    this.showPanel = true
  }

  aboutToAppear() {
    // 1.获取跳转时的参数
    //let params: any = router.getParams()
    // 2.获取点击的饮食记录类型
    //this.type = params.type
    this.type = router.getParams()['type']
    this.isFood = this.type.id != RecordTypeEnum.WORKOUT
  }

  build() {
    Row() {
      // TODO 使用Navigation实现
      Column() {
        // 头部导航
        Header({ title: this.type.name })
        // 列表
        ItemList({ showPanel: this.onPanelShow.bind(this), isFood: this.isFood })
          .layoutWeight(1)
        // 面板
        Panel(this.showPanel) {
          // 顶部日期
          PanelHeader({ title: this.type.name })
          if (this.item)
          // 记录项卡片
            ItemCard({ amountStr: this.amountStr, item: $item })
          // 数字键盘
          NumberKeyboard({ amount: $amount, amountStr: $amountStr })
          Row({ space: CommonConstants.SPACE_10 }) {
            Button('取消')
              .width(120)
              .backgroundColor($r('app.color.light_gray'))
              .onClick(() => this.showPanel = false)
            Button('确定')
              .width(120)
              .backgroundColor($r('app.color.primary_color'))
              .onClick(() => {
                // 持久化保存到数据库
                RecordService.insert(this.type.id, this.item.id, this.amount)
                this.showPanel = false
              })
          }.margin({ top: 10 })
        }
        .dragBar(false)
        .mode(PanelMode.Full)
        .backgroundColor(Color.White)
        .backgroundMask($r('app.color.light_gray'))
      }
      .height('100%')
      .width('100%')
    }
    .height('100%')
    .backgroundImageSize(ImageSize.Auto)
  }
}