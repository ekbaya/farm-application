import 'package:farm_app/database/Database_helper.dart';
import 'package:farm_app/models/Breed.dart';
import 'package:farm_app/models/Farmer.dart';
import 'package:farm_app/models/User.dart';

class FarmRepository{
  DatabaseHelper con = new DatabaseHelper();

  Future<int> registerUser(User user) async {
    var dbClient = await con.db;
    int res = await dbClient.insert("User", user.toMap());
    return res;
  }

  Future<int> registerFarmer(Farmer farmer) async {
    var dbClient = await con.db;
    int res = await dbClient.insert("farmer", farmer.toMap());
    return res;
  }

  Future<int> updateFarmer(Farmer farmer, int id) async {
    var dbClient = await con.db;
    int res = await dbClient.update("farmer", farmer.toMap(), where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> registerBreed(Breed breed) async {
    var dbClient = await con.db;
    int res = await dbClient.insert("breed", breed.toMap());
    return res;
  }
  
  Future<User> signInUser(String user, String password) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery("SELECT * FROM user WHERE username = '$user' and password = '$password'");
    
    if (res.length > 0) {
      return new User.fromMap(res.first);
    }
    return null;
  }

  Future<Farmer> getFarmerByID(int id) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery("SELECT * FROM farmer WHERE id = '$id'");
    
    if (res.length > 0) {
      return new Farmer.fromMap(res.first);
    }
    return null;
  }

  Future<List<Farmer>> getAllFarmers() async {
    var dbClient = await con.db;
    var res = await dbClient.query("farmer");
    
    List<Farmer> list =
        res.isNotEmpty ? res.map((c) => Farmer.fromMap(c)).toList() : null;
    return list;
  }

  Future<List<Breed>> getAllBreeds(String owner) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery("SELECT * FROM breed WHERE owner = '$owner'");
    
    List<Breed> list =
        res.isNotEmpty ? res.map((c) => Breed.fromMap(c)).toList() : null;
    return list;
  }

  //deletion
  Future<int> deleteUser(User user) async {
    var dbClient = await con.db;
    int res = await dbClient.delete("User");
    return res;
  }

  

}