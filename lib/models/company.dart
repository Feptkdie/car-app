class Company {
  int id;
  String name;
  String logo;
  String phone;
  String coordX;
  String coordY;
  String jsonData;

  Company({
    this.id,
    this.name,
    this.logo,
    this.phone,
    this.coordX,
    this.coordY,
    this.jsonData,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json["id"],
      name: json["name"],
      logo: json["logo"],
      phone: json["phone"],
      coordX: json["coordX"],
      coordY: json["coordY"],
      jsonData: json["jsonData"],
    );
  }
}
