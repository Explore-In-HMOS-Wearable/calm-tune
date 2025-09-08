import { NavigationService } from '../services/NavigationService';
import { AmbiencePage } from './AmbiencePage';
import { BreakPage } from './BreakPage';
import { HomePage } from './HomePage';
import { MusicPage } from './MusicPage';

@Entry
@Component
struct Index {
  navigationService: NavigationService = NavigationService.getInstance();

  @Builder
  routeMap(name: string) {
    NavDestination() {
      if (name === 'Home') {
        HomePage();
      } else if (name === 'AmbiencePage') {
        AmbiencePage();
      } else if (name === 'MusicPage') {
        MusicPage()
      } else if (name === 'BreakPage') {
        BreakPage();
      }
    }
    .onBackPressed( ()=>true )
    .hideTitleBar(true)
  }

  build() {
    Navigation(this.navigationService.pageInfos) {
      HomePage();
    }
    .mode(NavigationMode.Stack)
    .navDestination(this.routeMap)
    .ignoreLayoutSafeArea()
    .hideTitleBar(true)
    .width('100%')
    .height('100%')
  }
}
