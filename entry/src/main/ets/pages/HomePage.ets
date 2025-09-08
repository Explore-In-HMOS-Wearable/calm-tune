import { ArcButton, ArcButtonOptions, ArcButtonStyleMode, ColorMetrics } from '@kit.ArkUI';
import { MediaController } from '../utils/MediaController';
import { HomeViewModel } from '../viewmodel/HomeViewModel';
import { SongData } from '../model/SongData';

@Component
export struct HomePage {
  homeVm: HomeViewModel = new HomeViewModel();

  build() {
    Stack({alignContent: Alignment.Center})
    {
      Column({space: 8})
      {
        Text('CALMTUNE')
          .fontSize(26)
          .fontWeight(FontWeight.Bolder)
          .fontColor(Color.White)
          .textAlign(TextAlign.Center)

        Text('Pomodoro And Music')
          .fontSize(14)
          .fontWeight(FontWeight.Bolder)
          .fontColor('#ffeceaea')
          .textAlign(TextAlign.Center)
      }
      .zIndex(2)

      Image($r('app.media.home_bg'))
        .blur(9)
        .zIndex(1)
        .width('100%')
        .height('100%')
        .opacity(0.6)

      ArcButton({
        options: new ArcButtonOptions({
          label: 'START',
          styleMode: ArcButtonStyleMode.CUSTOM,
          backgroundColor: ColorMetrics.resourceColor('#ffa75d1c'),
          onClick: () => {
            this.homeVm.goToNextPage()
          }
        })
      })
        .offset({x: 0, y: 90})
        .zIndex(2)
    }
    .height('100%')
    .width('100%')
  }
}