import { BaseViewModel } from "./BaseViewModel";

@ObservedV2
export class MusicViewModel extends BaseViewModel {
  goToNextPage() {
    this.navigateToPage('BreakPage');
  }

  goToBackPage() {
    this.navigateToPage('AmbiencePage');
  }
}