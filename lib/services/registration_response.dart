import 'package:farm_app/models/User.dart';
import 'package:farm_app/services/registration_request.dart';
abstract class RegistrationCallback {
  void onRegistrationSuccess(int result);
  void onRegistrationError(String error);
}
class RegistratinResponse {
  RegistrationCallback _callBack;
  RegistrationRequest registrationRequest = new RegistrationRequest();
  RegistratinResponse(this._callBack);
  doRegistration(User user) {
    registrationRequest
        .getRegister(user)
        .then((result) => _callBack.onRegistrationSuccess(result))
        .catchError((onError) => _callBack.onRegistrationError(onError.toString()));
  } 
}