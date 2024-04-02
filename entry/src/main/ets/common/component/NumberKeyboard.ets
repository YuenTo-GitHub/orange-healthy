import { CommonConstants } from '../constants/CommonConstants'

@Component
export default struct NumberKeyboard {
  keys: string[] = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '.', '0']
  @Link amount: number
  @Link amountStr: string

  @Styles keyStyle(){
    .backgroundColor(Color.White)
    .height(60)
    .borderRadius(8)
  }

  parseFloat(str: string): number {
    if (str.endsWith('.')) {
      str = str.substring(0, str.length - 1)
    }
    return parseFloat(str)
  }

  inputNumber(key: string) {
    let str = this.amountStr + key
    let firstDot = str.indexOf('.')
    let lastDot = str.lastIndexOf('.')
    // 是否输入了两个小数点或者超过一位小数
    if (firstDot != lastDot || (lastDot != -1 && lastDot < str.length - 2)) {
      return
    }
    // 原数值为0且输入的是数字，不拼接，直接替换
    if (this.amountStr == '0' && key != '.') {
      str = key
    }
    // 将字符串转为数值
    let amount = this.parseFloat(str)
    if (amount >= 999.9) {
      this.amount = 999.0
      this.amountStr = '999'
    } else {
      this.amount = amount
      this.amountStr = str
    }
  }

  deleteNumber() {
    let length = this.amountStr.length
    if (length > 1) {
      this.amountStr = this.amountStr.substring(0, length - 1)
      this.amount = this.parseFloat(this.amountStr)
    } else {
      this.amountStr = '0'
      this.amount = 0
    }
  }

  build() {
    Grid() {
      ForEach(this.keys, key => {
        GridItem() {
          Text(key).fontSize(20).fontWeight(CommonConstants.FONT_WEIGHT_900)
        }
        .keyStyle()
        .onClick(() => {
          this.inputNumber(key)
        })
      })
      GridItem() {
        Text('删除').fontSize(20).fontWeight(CommonConstants.FONT_WEIGHT_900)
      }.keyStyle()
      .onClick(() => {
        this.deleteNumber()
      })
    }
    .padding(8)
    .rowsGap(8)
    .height(280)
    .columnsGap(8)
    .margin({ top: 10 })
    .columnsTemplate('1fr 1fr 1fr')
    .width(CommonConstants.THOUSANDTH_1000)
    .backgroundColor($r('app.color.index_page_background'))
  }
}