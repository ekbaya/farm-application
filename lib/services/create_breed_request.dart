import 'dart:async';
import 'package:farm_app/models/Breed.dart';
import 'package:farm_app/repository/FarmRepository.dart';
class BreedRegistrationRequest {
  FarmRepository repository = new FarmRepository();
 Future<int> getRegisterBreed(Breed breed) {
    var result = repository.registerBreed(breed);
    return result;
  }
}