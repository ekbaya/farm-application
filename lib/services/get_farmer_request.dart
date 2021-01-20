import 'dart:async';
import 'package:farm_app/models/Farmer.dart';
import 'package:farm_app/repository/FarmRepository.dart';
class GetFarmerRequest {
  FarmRepository repository = new FarmRepository();
 Future<Farmer> getFarmer(int id) {
    var result = repository.getFarmerByID(id);
    return result;
  }
}