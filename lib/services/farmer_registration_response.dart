
import 'package:farm_app/models/Farmer.dart';
import 'package:farm_app/services/farmer_registration_request.dart';
abstract class FarmerRegistrationCallback {
  void onRegistrationSuccess(int result);
  void onRegistrationError(String error);
}
class FarmerRegistratinResponse {
  FarmerRegistrationCallback _callBack;
  FarmerRegistrationRequest registrationRequest = new FarmerRegistrationRequest();
  FarmerRegistratinResponse(this._callBack);
  doRegistration(Farmer farmer) {
    registrationRequest
        .getRegisterFarmer(farmer)
        .then((result) => _callBack.onRegistrationSuccess(result))
        .catchError((onError) => _callBack.onRegistrationError(onError.toString()));
  } 
}