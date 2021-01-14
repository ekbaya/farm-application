import 'package:farm_app/database/Database_helper.dart';
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
  
  Future<User> signInUser(String user, String password) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery("SELECT * FROM user WHERE username = '$user' and password = '$password'");
    
    if (res.length > 0) {
      return new User.fromMap(res.first);
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

  //deletion
  Future<int> deleteUser(User user) async {
    var dbClient = await con.db;
    int res = await dbClient.delete("User");
    return res;
  }
}