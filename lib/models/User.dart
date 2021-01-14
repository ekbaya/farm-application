class User {
  int _id;
  String username, password;
  User({this.username, this.password});

  Map<String, dynamic> toMap() => {
        "username": username,
        "password": password,
      };

  factory User.fromMap(Map<String, dynamic> json) => new User(
        username: json["username"],
        password: json["password"],
      );
}
