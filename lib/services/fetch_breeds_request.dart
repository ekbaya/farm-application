import 'package:farm_app/models/Breed.dart';
import 'package:farm_app/repository/FarmRepository.dart';
class FetchBreedsRequest {
FarmRepository repository = new FarmRepository();
 Future<List<Breed>> getBreeds(String owner) {
    var result = repository.getAllBreeds(owner);
    return result;
  }
}