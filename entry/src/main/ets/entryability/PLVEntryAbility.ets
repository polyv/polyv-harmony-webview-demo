import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';
import { PLVLogger, PLVWebViewWindowManager } from 'plvwebsdk'

const TAG = "[PLVEntryAbility]"
// const CONTENT = "pages/PLVInputPage"
const CONTENT = "pages/PLVEntrancePage"

export default class PLVEntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    PLVLogger.info(TAG, 'Ability onCreate');
  }

  onDestroy(): void {
    PLVLogger.info(TAG, 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    PLVLogger.info(TAG, 'Ability onWindowStageCreate');
    // demo核心代码
    PLVWebViewWindowManager.setWindowStage(windowStage)

    windowStage.loadContent(CONTENT, new LocalStorage(), (err, data) => {
      if (err.code) {
        PLVLogger.info(TAG, 'Failed to load the content. Cause: ' + JSON.stringify(err) ?? '');
        return;
      }
      PLVLogger.info(TAG, 'Succeeded in loading the content. Data: ' + JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    PLVLogger.info(TAG, 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    PLVLogger.info(TAG, 'Ability onForeground');
    // demo核心代码
    PLVWebViewWindowManager?.onForeground()
  }

  onBackground(): void {
    // Ability has back to background
    PLVLogger.info(TAG, 'Ability onBackground');
    // demo核心代码
    PLVWebViewWindowManager?.onBackground()
  }
}
