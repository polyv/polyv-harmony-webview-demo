import { PLVWeb, PLVCommonConstants, PLVWebController, PLVWebViewConfig } from "PLVWebSDK"

@Entry
@Component
struct PLVWebPage {
  @StorageLink('inputWebConfig') config: PLVWebViewConfig = new PLVWebViewConfig().setUrl("")
  @State controller: PLVWebController = new PLVWebController({ config: this.config!! })

  aboutToAppear(): void {
    // this.controller.registerHandler("自定义事件", (data: string) => {
    //   // 监听自定义事件的处理
    // })
    // this.controller.callHandle("发送原生事件", "xxx", () => {
    //   //发送原生事件
    // })
    // this.controller.registerCustomerContainEvent({
    //   onShare: () => {
    //     // 监听到onShare事件时的操作
    //     return true // return true表示拦截掉分享事件 false就继续由sdk往下执行
    //   }
    // })
  }

  build() {
    Column() {
      PLVWeb({ controller: this.controller })
    }
    .width(PLVCommonConstants.FULL_PERCENT)
  }

  onBackPress(): boolean | void {
    if (this.controller.accessBackward()) {
      this.controller.backward()
      return true
    }
    return false
  }
}