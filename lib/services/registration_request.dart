import 'dart:async';
import 'package:farm_app/models/User.dart';
import 'package:farm_app/repository/FarmRepository.dart';
class RegistrationRequest {
  FarmRepository repository = new FarmRepository();
 Future<int> getRegister(User user) {
    var result = repository.registerUser(user);
    return result;
  }
}