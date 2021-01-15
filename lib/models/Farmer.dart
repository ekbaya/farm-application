class Farmer {
  String name, phone, country;
  int id;
  Farmer({this.id, this.name, this.phone, this.country});

  Map<String, dynamic> toMap() =>
      {"name": name, "phone": phone, "country": country};

  factory Farmer.fromMap(Map<String, dynamic> json) => new Farmer(
        id: json['id'],
        name: json["name"],
        phone: json["phone"],
        country: json["country"],
      );
}
