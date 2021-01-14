import 'dart:async';
import 'package:farm_app/models/Farmer.dart';
import 'package:farm_app/repository/FarmRepository.dart';
class FetchFarmersRequest {
FarmRepository repository = new FarmRepository();
 Future<List<Farmer>> getFarmers() {
    var result = repository.getAllFarmers();
    return result;
  }
}