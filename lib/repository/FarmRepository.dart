import 'package:farm_app/database/Database_helper.dart';
import 'package:farm_app/models/User.dart';

class FarmRepository{
  DatabaseHelper con = new DatabaseHelper();
//insertion
  Future<int> registerUser(User user) async {
    var dbClient = await con.db;
    int res = await dbClient.insert("User", user.toMap());
    return res;
  }
  //deletion
  Future<int> deleteUser(User user) async {
    var dbClient = await con.db;
    int res = await dbClient.delete("User");
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
  Future<List<User>> getAllUsers() async {
    var dbClient = await con.db;
    var res = await dbClient.query("user");
    
    List<User> list =
        res.isNotEmpty ? res.map((c) => User.fromMap(c)).toList() : null;
    return list;
  }
}