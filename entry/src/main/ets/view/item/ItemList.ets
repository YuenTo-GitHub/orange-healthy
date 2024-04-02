import { CommonConstants } from '../../common/constants/CommonConstants'
import ItemModel from '../../model/ItemModel'
import GroupInfo from '../../viewmodel/GroupInfo'
import ItemCategory from '../../viewmodel/ItemCategory'
import RecordItem from '../../viewmodel/RecordItem'

@Extend(Text) function grayText() {
  .fontSize(14)
  .fontColor($r('app.color.light_gray'))
}

@Component
export default struct ItemList {
  @State currentTabIndex: number = 0
  @Prop isFood: boolean
  showPanel: (item: RecordItem) => void

  @Builder TabBarBuilder(title: ResourceStr, index: number) {
    Column() {
      if (this.currentTabIndex === index) {
        // 当前分类被选中
        Text(title)
          .fontSize(16)
          .fontColor($r('app.color.primary_color'))
        Divider()
          .width(10)
          .strokeWidth(2)
          .lineCap(LineCapStyle.Round)
          .color($r('app.color.primary_color'))
      } else {
        Text(title)
          .fontSize(16)
        Divider()
          .width(10)
          .strokeWidth(2)
          .opacity(0)
      }
    }.margin({ left: 10, right: 10 })
  }

  @Builder TabContentList(items: RecordItem[]) {
    List({ space: CommonConstants.SPACE_10 }) {
      ForEach(items, (item: RecordItem) => {
        ListItem() {
          Row({ space: CommonConstants.SPACE_6 }) {
            Image(item.image).width(50)
            Column({ space: CommonConstants.SPACE_4 }) {
              Text(item.name).fontWeight(CommonConstants.FONT_WEIGHT_500)
              Text(`${item.calorie}千卡/${item.unit}`).grayText()
            }.alignItems(HorizontalAlign.Start)

            Blank()
            Image($r('app.media.ic_public_add_norm_filled'))
              .width(20)
              .fillColor($r('app.color.primary_color'))
              .onClick(() => this.showPanel(item))
          }
          .width(CommonConstants.THOUSANDTH_1000)
        }
      })
    }
    .width(CommonConstants.THOUSANDTH_1000)
    .height(CommonConstants.THOUSANDTH_1000)
  }

  build() {
    Tabs() {
      TabContent() {
        this.TabContentList(ItemModel.list(this.isFood))
      }.tabBar(this.TabBarBuilder('全部', 0))

      ForEach(ItemModel.listItemGroupByCategory(this.isFood), (group: GroupInfo<ItemCategory, RecordItem>, index) => {
        TabContent() {
          this.TabContentList(group.items)
        }.tabBar(this.TabBarBuilder(group.type.name, index + 1))
      })
    }.width(CommonConstants.THOUSANDTH_940)
    .height(CommonConstants.THOUSANDTH_1000)
    .barMode(BarMode.Scrollable)
    .onChange(index => this.currentTabIndex = index)
  }
}