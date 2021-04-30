class Company {
  int id;
  String name;
  String logo;
  String address;
  String coordX;
  String coordY;

  Company({
    this.id,
    this.name,
    this.logo,
    this.address,
    this.coordX,
    this.coordY,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json["id"],
      name: json["name"],
      logo: json["logo"],
      address: json["address"],
      coordX: json["coordX"],
      coordY: json["coordY"],
    );
  }
}
