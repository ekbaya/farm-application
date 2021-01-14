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

  factory User.fromJson(Map<String, dynamic> json)=>userFromJson(json);

  Map<String, dynamic> toJson() => userToJson(this);
}

User userFromJson(Map<String, dynamic> json){
  return User(
    username: json['username'] as String,
    password: json['password'] as String
  );
}

Map<String, dynamic> userToJson(User instance) => <String, dynamic>{
  'username': instance.username,
  'password': instance.password,
};
