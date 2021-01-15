
import 'package:farm_app/models/Breed.dart';
import 'package:farm_app/services/create_breed_request.dart';
abstract class BreedRegistrationCallback {
  void onRegistrationSuccess(int result);
  void onRegistrationError(String error);
}
class BreedRegistratinResponse {
  BreedRegistrationCallback _callBack;
  BreedRegistrationRequest registrationRequest = new BreedRegistrationRequest();
  BreedRegistratinResponse(this._callBack);
  doRegistration(Breed breed) {
    registrationRequest
        .getRegisterBreed(breed)
        .then((result) => _callBack.onRegistrationSuccess(result))
        .catchError((onError) => _callBack.onRegistrationError(onError.toString()));
  } 
}