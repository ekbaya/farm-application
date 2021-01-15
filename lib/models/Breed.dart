class Breed{
  String owner,name, number;
  Breed({this.owner, this.name, this.number});

   Map<String, dynamic> toMap() =>
      {"owner": owner, "name": name, "number": number};

  factory Breed.fromMap(Map<String, dynamic> json) => new Breed(
        owner: json['owner'],
        name: json["name"],
        number: json["number"],
      );
}