import { PLVCommonConstants, PLVWebViewConfig, PLVWebViewWindowManager, PLVUAConfig, PLVUtils } from 'PLVWebSDK'
import router from '@ohos.router'

let storage = LocalStorage.getShared()

@Entry(storage)
@Component
struct PLVInputPage {
  inputUrl: string = 'https://www.polyv.net'
  config: PLVWebViewConfig = new PLVWebViewConfig().setUa("Android" + PLVUAConfig.defaultUA)
    .setUrl(this.inputUrl)
    .setSupportAutoFloating(false)
    .setAllowFloatingWindow(true)

  build() {
    Column() {
      Text("Web Demo")
        .fontWeight(FontWeight.Bold)
        .fontSize(24)
        .margin(24)
      Column() {
        Text("方式一：")
          .margin({ bottom: 16 })
          .fontSize(18)
          .width(PLVCommonConstants.FULL_PERCENT)
        TextInput({ placeholder: "输入URL", text: this.inputUrl })
          .maxLines(1)
          .showUnderline(true)
          .onChange((text) => {
            this.config.setUrl(text)
            this.inputUrl = text
          })
        Button("打开Web")
          .margin(24)
          .onClick(() => {
            if (!PLVWebViewWindowManager?.getWebViewWindow()) {
              this.config.setUrl(this.inputUrl)
              AppStorage.setOrCreate('inputWebConfig', this.config);
              PLVWebViewWindowManager?.initWindow(true, "pages/PLVWebPage")
              return
            }
          })
      }
      .width(PLVCommonConstants.FULL_PERCENT)
      .margin({ top: 24 })
      Divider()
      Column() {
        Text("方式二：")
          .fontSize(18)
          .width(PLVCommonConstants.FULL_PERCENT)
        Button("打开二维码扫描")
          .margin(24)
          .onClick(() => {
            PLVUtils.startScan(this).then((result: string) => {
              this.inputUrl = result
              this.config.setUrl(this.inputUrl)
              AppStorage.setOrCreate('inputWebConfig', this.config);
              PLVWebViewWindowManager?.initWindow(true, "pages/PLVWebPage")
            })
          })
      }
      .width(PLVCommonConstants.FULL_PERCENT)
      .margin({ top: 24 })
    }
    .padding(8)
    .width(PLVCommonConstants.FULL_PERCENT)
    .height(PLVCommonConstants.FULL_PERCENT)
  }
}