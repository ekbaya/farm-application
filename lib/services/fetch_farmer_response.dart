import 'package:farm_app/models/Farmer.dart';
import 'package:farm_app/services/fetch_farmers_request.dart';
abstract class FetchFarmerCallBack {
  void onDataFetched(List<Farmer> farmers);
  void onFetchError(String error);
}
class FetchFarmerResponse {
  FetchFarmerCallBack _callBack;
  FetchFarmersRequest fetchFarmerRequest = new FetchFarmersRequest();
  FetchFarmerResponse(this._callBack);
  doFetching() {
    fetchFarmerRequest
        .getFarmers()
        .then((farmers) => _callBack.onDataFetched(farmers))
        .catchError((onError) => _callBack.onFetchError(onError.toString()));
  } 
}