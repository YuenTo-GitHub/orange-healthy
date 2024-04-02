import router from '@ohos.router'
import { CommonConstants } from '../../common/constants/CommonConstants'
import DateUtil from '../../common/utils/DateUtil'
import RecordService from '../../service/RecordService'
import GroupInfo from '../../viewmodel/GroupInfo'
import RecordType from '../../viewmodel/RecordType'
import RecordVO from '../../viewmodel/RecordVO'

@Extend(Text) function grayText() {
  .fontSize(14)
  .fontColor($r('app.color.light_gray'))
}

@Component
export default struct RecordList {
  @Consume @Watch('handleRecordsChange') records: RecordVO[]
  @State groups: GroupInfo<RecordType, RecordVO>[] = []
  @StorageProp('selectedDate') selectedDate: number = DateUtil.beginTimeOfDay(new Date())

  handleRecordsChange() {
    this.groups = RecordService.calculateGroupInfo(this.records)
  }

  @Builder deleteButton(id: number) {
    Image($r('app.media.ic_public_delete_filled'))
      .fillColor(Color.Red)
      .height(20)
      .width(20)
      .margin({ left: 4 })
      .onClick(() => {
        RecordService.deleteById(id)
          .then(async () => {
            this.records = await RecordService.queryRecordByDate(this.selectedDate)
          })
      })
  }

  build() {
    List({ space: CommonConstants.SPACE_10 }) {
      ForEach(this.groups, (group: GroupInfo<RecordType, RecordVO>) => {
        ListItem() {
          Column({ space: CommonConstants.SPACE_2 }) {
            // 组标题
            Row({ space: CommonConstants.SPACE_4 }) {
              //TODO 当天已摄入多少千卡，图标就有一定的比例变色
              Image(group.type.icon).width(24)
              Text(group.type.name).fontSize(18).fontWeight(CommonConstants.FONT_WEIGHT_700)
              Text(`建议${group.type.min}~${group.type.max}千卡`).grayText()
              Blank()
              Row() {
                Text(group.calorie.toFixed(0)).fontSize(14).fontColor($r('app.color.primary_color'))
                Text('千卡').grayText()
              }

              Image($r('app.media.ic_public_add_norm_filled'))
                .width(20)
                .fillColor($r('app.color.primary_color'))
                .onClick(() => {
                  router.pushUrl({
                    url: 'pages/ItemAddPage',
                    params: {
                      type: group.type
                    }
                  }, router.RouterMode.Single)
                })
            }.width(CommonConstants.THOUSANDTH_1000)
            // 组记录
            List() {
              ForEach(group.items, (item: RecordVO) => {
                ListItem() {
                  Row({ space: CommonConstants.SPACE_6 }) {
                    Image(item.recordItem.image).width(50)
                    Column({ space: CommonConstants.SPACE_4 }) {
                      Text(item.recordItem.name).fontWeight(CommonConstants.FONT_WEIGHT_500)
                      Text(`${item.amount}${item.recordItem.unit}`).grayText()
                    }.alignItems(HorizontalAlign.Start)

                    Blank()
                    Text(`${item.calorie}千卡`).grayText()
                  }
                  .width(CommonConstants.THOUSANDTH_1000)
                }.swipeAction({ end: this.deleteButton(item.id) })
              })
            }
            .width(CommonConstants.THOUSANDTH_1000)
          }
          .backgroundColor(Color.White)
          .width(CommonConstants.THOUSANDTH_1000)
          .borderRadius(CommonConstants.DEFAULT_18)
          .padding(CommonConstants.SPACE_12)
        }
      })
    }
    .margin({ top: CommonConstants.DEFAULT_10 })
    .width(CommonConstants.THOUSANDTH_940)
  }
}