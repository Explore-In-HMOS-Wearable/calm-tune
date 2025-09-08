import { MediaController } from '../utils/MediaController';
import { SongData } from '../model/SongData';
import { PlayPauseButton } from './PlayPauseButton';

@Extend(Image)
function controlImageBuilder() {
  .aspectRatio(1)
  .objectFit(ImageFit.Contain)
}

@Component
export struct PlaybackView {
  @StorageLink('selectIndex') selectIndex: number = 0;
  @StorageLink('songList') songList: SongData[] = [];
  @StorageLink('currentTime') currentTime: string = '00:00';
  @StorageLink('totalTime') totalTime: string = '00:00';

  build() {
    Stack() {
      Column() {
        Column() {
          Text(this.currentTime)
            .fontColor(Color.Blue)
            .fontSize(12)
          Text(this.songList[this.selectIndex].title)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Blue)
            .margin({ top: 4 })
          Text(this.songList[this.selectIndex].artist)
            .fontSize(FontWeight.Normal)
            .fontColor(Color.Blue)
        }
        .justifyContent(FlexAlign.Center)
        .margin({ top: 10 })

        Row() {
          Image($r('app.media.back'))
            .controlImageBuilder()
            .width(30)
            .onClick(() => {
              MediaController.getInstance().playPrevious();
            })

          PlayPauseButton()

          Image($r('app.media.end'))
            .controlImageBuilder()
            .width(30)
            .onClick(() => {
              MediaController.getInstance().playNext();
            })
        }
        .layoutWeight(1)
        .padding({
          left: 4,
          right: 4,
          bottom: 8,
        })
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)
        .alignItems(VerticalAlign.Center)
      }
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}