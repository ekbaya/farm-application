import 'dart:async';
import 'package:farm_app/models/User.dart';
import 'package:farm_app/repository/FarmRepository.dart';
class LoginRequest {
  FarmRepository repository = new FarmRepository();
 Future<User> getLogin(String username, String password) {
    var result = repository.signInUser(username,password);
    return result;
  }
}