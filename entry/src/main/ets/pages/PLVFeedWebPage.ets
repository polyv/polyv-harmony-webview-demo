import { PLVFeedData, PLVFeedWeb,
  PLVPullToRefreshConfigurator,
  PLVUAConfig, PLVWebController, PLVWebViewConfig } from 'plvwebsdk/Index'
import ArrayList from '@ohos.util.ArrayList'


@Entry
@Component
struct PLVFeedWebPage {
  @StorageLink('inputWebConfigFeed') listUrl: ArrayList<string> = new ArrayList()

  @State data: PLVFeedData = new PLVFeedData()
  @State index: number = 0

  private urls: string[] = [
    'https://www.polyv.net',
    'https://www.polyv.net'
  ]

  private onLoadMore?: () => Promise<string> = () => {
    return new Promise<string>((resolve, reject) => {
      setTimeout(() => {
        resolve('')
        let urls: string[] = [
          'https://www.polyv.net'
        ]
        let config: PLVWebViewConfig = new PLVWebViewConfig()
          .setUa("Android" + PLVUAConfig.defaultUA).setSupportAutoFloating(true).setAllowFloatingWindow(true)
        for (let element of urls) {
          let tempConfig: PLVWebViewConfig = config.clone().setUrl(element)
          let controller: PLVWebController = new PLVWebController({config: tempConfig})
          this.data.pushData(controller)
        }
      }, 3000);
    });
  }

  private onRefresh?: () => Promise<string> = () => {
    return new Promise<string>((resolve, reject) => {
      setTimeout(() => {
        resolve("success")
      }, 1000)
    })
  }

  aboutToAppear(): void {
    let config: PLVWebViewConfig = new PLVWebViewConfig()
      .setUa("Android" + PLVUAConfig.defaultUA).setSupportAutoFloating(false).setAllowFloatingWindow(true)

    if (this.listUrl.length > 0) {
      for (let item of this.listUrl) {
        console.info("===" + item)
        let tempConfig: PLVWebViewConfig = config.clone().setUrl(item)
        let controller: PLVWebController = new PLVWebController({config: tempConfig})
        this.data.pushData(controller)
      }
    } else {
      for (let url of this.urls) {
        let tempConfig: PLVWebViewConfig = config.clone().setUrl(url)
        let controller: PLVWebController = new PLVWebController({config: tempConfig})
        this.data.pushData(controller)
      }
    }
  }

  build() {
    Column() {
      PLVFeedWeb({
        data: this.data,
        onLoadMore: this.onLoadMore,
        onRefresh: this.onRefresh,
        index: this.index
      })
    }
    .width('100%')
  }

  onBackPress(): boolean | void {
    let controller = this.data.getData(this.index)
    if (controller.accessBackward()) {
      controller.backward()
      return true
    }
    return false
  }
}