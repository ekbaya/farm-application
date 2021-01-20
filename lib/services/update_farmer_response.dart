import 'package:farm_app/models/Farmer.dart';
import 'package:farm_app/models/User.dart';
import 'package:farm_app/services/update_farmer_request.dart';
abstract class UpdationCallback {
  void onSuccessUpdation(int result);
  void onError(String error);
}
class UpdateFarmerResponse {
  UpdationCallback _callBack;
  UpdateFarmerRequest updateFarmerRequest = new UpdateFarmerRequest();
  UpdateFarmerResponse(this._callBack);
  doFarmerUpdation(Farmer farmer, int id) {
    updateFarmerRequest
        .getUpdate(farmer, id)
        .then((result) => _callBack.onSuccessUpdation(result))
        .catchError((onError) => _callBack.onError(onError.toString()));
  } 
}