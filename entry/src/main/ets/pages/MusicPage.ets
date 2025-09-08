import { ArcButton, ArcButtonOptions, ArcButtonStyleMode, ColorMetrics } from '@kit.ArkUI';
import { DataModel } from '../viewmodel/DataModel';
import { MediaController } from '../utils/MediaController';
import { SongData } from '../model/SongData';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { MusicViewModel } from '../viewmodel/MusicViewModel';

@Component
export struct MusicPage {
  private gradientColor: LinearGradient = new LinearGradient([{ color: Color.Yellow, offset: 0.5 },
    { color: Color.Orange, offset: 1.0 }])
  musicVm : MusicViewModel = new MusicViewModel()

  textTimerController: TextTimerController = new TextTimerController()
  @State format: string = 'mm:ss'
  @State count: number = 1500000
  @State songs: SongData[] = [];

  @Prop isPlaying : boolean = true
  @State currCount : number = 0

  @StorageLink('selectIndex') selectIndex: number = 0;
  @StorageLink('songList') songList: SongData[] = [];
  @StorageLink('currentTime') currentTime: string = '00:00';
  @StorageLink('totalTime') totalTime: string = '00:00';

  @StorageLink('isPlay') isPlay: boolean = false;
  @StorageLink('progress') value: number = 0;
  @StorageLink('progressMax') max: number = 0;

  aboutToAppear(): void {
   /* this.songs = DataModel.SONG_LIST
    AppStorage.setOrCreate('songList', this.songs);*/
    MediaController.getInstance();
  }

  aboutToDisappear(): void {
    MediaController.getInstance().release();
    MediaController.clearController()
  }

  onBackPress(): boolean | void {
    MediaController.getInstance().release();
    MediaController.clearController()

    this.textTimerController.reset()
    this.textTimerController.pause()
  }

  build() {
    Stack() {
      Progress({ value: 0, total: 1500, type: ProgressType.Ring })
        .width('100%')
        .style({ strokeWidth: 12 })
        .color(this.gradientColor)
        .width('100%')
        .zIndex(3)
        .value(this.currCount)

      TextTimer({ isCountDown: true, count: this.count, controller: this.textTimerController })
        .format(this.format)
        .fontColor(Color.White)
        .fontSize(48)
        .onTimer((utc: number, elapsedTime: number) => {
          console.info('textTimer notCountDown utc is: ' + utc + ', elapsedTime: ' + elapsedTime)
          this.currCount = elapsedTime

          if(this.currCount === 1500)
          {
            this.musicVm.goToNextPage()

            MediaController.getInstance().release();
            MediaController.clearController()

            this.textTimerController.reset()
            this.textTimerController.pause()
          }
        })
        .onAppear(()=>{
          this.textTimerController.start()
        })
        .fontWeight(FontWeight.Bolder)
        .offset({x: 0, y: -60})
        .zIndex(3)

      ArcButton({
        options: new ArcButtonOptions({
          label: 'EXIT',
          styleMode: ArcButtonStyleMode.CUSTOM,
          backgroundColor: ColorMetrics.resourceColor(Color.Orange),
          onClick: () => {
            this.musicVm.goToBackPage()

            MediaController.getInstance().release();
            MediaController.clearController()

            this.textTimerController.reset()
            this.textTimerController.pause()
          }
        })
      })
        .offset({x: 0, y: 68})
        .zIndex(3)

      Row()
      {
        Image($r('app.media.back'))
          .width(36)
          .height(36)
          .fillColor(Color.Orange)
          .onClick(() => {
            MediaController.getInstance().playPrevious();
          })

        Image(this.isPlay ? $r('app.media.pause') : $r('app.media.play'))
          .width(36)
          .height(36)
          .fillColor(Color.Orange)
          .onClick(() => {
            hilog.error(0xFF00, ' tag MusicPlay', `onClick play pause ${this.isPlay}`);

            if (this.isPlay) {
              MediaController.getInstance().pause();
            } else {
              if (MediaController.getInstance().getFirst()) {
                MediaController.getInstance().startByIndex(0);
              } else {
                MediaController.getInstance().resume();
              }
            }
          })

        Image($r('app.media.next'))
          .width(36)
          .height(36)
          .fillColor(Color.Orange)
          .onClick(() => {
            MediaController.getInstance().playNext();
          })
      }
      .zIndex(4)

      Image($r('app.media.ambience_bg'))
        .width('100%')
        .height('100%')
        .opacity(0.4)
        .zIndex(1)
    }
    .onAppear(() => {
      MediaController.getInstance().startByIndex(0);
    })
  }
}