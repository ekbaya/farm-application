import 'package:farm_app/models/Breed.dart';

import 'fetch_breeds_request.dart';
abstract class FetchBreedCallBack {
  void onDataFetched(List<Breed> breeds);
  void onFetchError(String error);
}
class FetchBreedResponse {
  FetchBreedCallBack _callBack;
  FetchBreedsRequest fetchFarmerRequest = new FetchBreedsRequest();
  FetchBreedResponse(this._callBack);
  doFetching(String owner) {
    fetchFarmerRequest
        .getBreeds(owner)
        .then((breeds) => _callBack.onDataFetched(breeds))
        .catchError((onError) => _callBack.onFetchError(onError.toString()));
  } 
}