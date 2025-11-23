import { BaseViewModel } from './BaseViewModel';

@ObservedV2
export class AmbienceViewModel extends BaseViewModel {
  goToNextPage() {
    this.navigateToPage('MusicPage');
  }
}