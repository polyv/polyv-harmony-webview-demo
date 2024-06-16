import { router } from '@kit.ArkUI'
import { PLVUAConfig, PLVWebViewWindowManager } from 'PLVWebSDK'
import ArrayList from '@ohos.util.ArrayList'

let storage = LocalStorage.getShared()

@Preview
@Entry(storage)
@Component
struct Entrance {
  inputUrl: string = ''
  configs: ArrayList<string> = new ArrayList()


  build() {
    Column( {space: 100} ) {

      // TextArea({ placeholder: "测试feed流url，如输入多个则需要换行", text: this.inputUrl, })
      //   .onChange((text) => {
      //     this.inputUrl = text
      //   })
      //   .enterKeyType(EnterKeyType.NEW_LINE)
      //   .width("100%")


      Button({type: ButtonType.Normal}) {
        Text("Single-WebView")
          .fontColor("#FFFFFF")
      }
        .onClick((event) => {
          router.pushUrl({
            url: 'pages/PLVInputPage'
          }, router.RouterMode.Standard)
        })
        .width('60%').height("100").backgroundColor("#FF00C4F7").borderRadius(0)

      Button({type: ButtonType.Normal}) {
        Text("Feed-WebView")
          .fontColor("#FFFFFF")
      }
      .onClick((event) => {
        this.regData(this.inputUrl)
        AppStorage.setOrCreate('inputWebConfigFeed', this.configs)
        if (!PLVWebViewWindowManager?.getWebViewWindow()) {
          PLVWebViewWindowManager?.initWindow(true, "pages/PLVFeedWebPage")
          return
        }
      })
        .width('60%').height("100").backgroundColor("#FF8468F3").borderRadius(0)
    }
    .width('100%').height("100%")
    .justifyContent(FlexAlign.Center)
  }

  private regData(data: string) {
    this.configs.clear()
    if (data.length == 0) {
      return
    }
    let lines = data.split("\n")
    for (let item of lines) {
      this.configs.add(item)
    }
  }
}