import 'package:farm_app/models/Farmer.dart';
import 'package:farm_app/services/get_farmer_request.dart';
abstract class FarmerCallBack {
  void onFarmerReceived(Farmer farmer);
  void onFetchFarmerError(String error);
}
class GetFarmerResponse {
  FarmerCallBack _callBack;
  GetFarmerRequest farmerRequest = new GetFarmerRequest();
  GetFarmerResponse(this._callBack);
  doFetchFarmer(int id) {
    farmerRequest
        .getFarmer(id)
        .then((farmer) => _callBack.onFarmerReceived(farmer))
        .catchError((onError) => _callBack.onFetchFarmerError(onError.toString()));
  } 
}