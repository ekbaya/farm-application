import 'dart:async';
import 'package:farm_app/models/Farmer.dart';
import 'package:farm_app/repository/FarmRepository.dart';
class FarmerRegistrationRequest {
  FarmRepository repository = new FarmRepository();
 Future<int> getRegisterFarmer(Farmer farmer) {
    var result = repository.registerFarmer(farmer);
    return result;
  }
}