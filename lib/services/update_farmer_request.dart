import 'dart:async';
import 'package:farm_app/models/Farmer.dart';
import 'package:farm_app/repository/FarmRepository.dart';
class UpdateFarmerRequest {
 FarmRepository repository = new FarmRepository();
 Future<int> getUpdate(Farmer farmer, int id) {
    var result = repository.updateFarmer(farmer, id);
    return result;
  }
}