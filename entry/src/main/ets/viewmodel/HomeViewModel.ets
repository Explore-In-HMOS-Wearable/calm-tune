import { DataModel } from "./DataModel";
import { BaseViewModel } from "./BaseViewModel";
import { SongData } from "../model/SongData";

@ObservedV2
export class HomeViewModel extends BaseViewModel {
  goToNextPage() {
    this.navigateToPage('AmbiencePage');
  }

  public getSongList(): SongData[] {
    return DataModel.LOFI;
  }
}