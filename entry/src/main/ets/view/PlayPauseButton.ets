import { hilog } from '@kit.PerformanceAnalysisKit';
import { MediaController } from '../utils/MediaController';

@Component
export struct PlayPauseButton {
  @StorageLink('isPlay') isPlay: boolean = false;
  @StorageLink('progress') value: number = 0;
  @StorageLink('progressMax') max: number = 0;

  build() {
    Stack() {
      RelativeContainer() {
        Image(this.isPlay ? $r('app.media.pause') : $r('app.media.play'))
          .aspectRatio(1)
          .objectFit(ImageFit.Contain)
          .width(30)
          .alignRules({
            center: { anchor: '__container__', align: VerticalAlign.Center },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })
      }
      .width('100%')
      .borderRadius(20)
      .aspectRatio(1)
      .backgroundColor(Color.Gray)

      Progress({
        value: this.value,
        total: this.max,
        type: ProgressType.Ring
      })
        .aspectRatio(1)
        .value(this.value)
        .width('100%')
        .color(Color.Blue)
        .style({ strokeWidth: 8 })
        .backgroundColor(Color.Yellow)
    }
    .width('40%')
    .height('40%')
    .alignContent(Alignment.Center)
    .onClick(() => {
      hilog.error(0xFF00, ' tag MusicPlay', `onClick play pause ${this.isPlay}`);

      if (this.isPlay) {
        MediaController.getInstance().pause();
      } else {
        if (MediaController.getInstance().getFirst()) {
          MediaController.getInstance().startByIndex();
        } else {
          MediaController.getInstance().resume();
        }
      }
    })
  }
}