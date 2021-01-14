class Farmer{
  String name, phone, country;
  Farmer({this.name, this.phone, this.country});

   Map<String, dynamic> toMap() => {
        "name": name,
        "phone": phone,
        "country":country
      };

  factory Farmer.fromMap(Map<String, dynamic> json) => new Farmer(
        name: json["name"],
        phone: json["phone"],
        country: json["country"],
      );
}