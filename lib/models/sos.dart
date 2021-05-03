class Sos {
  int id;
  int categoryId;
  String title;
  String image;
  String address;
  String phone;
  String coordX;
  String coordY;

  Sos({
    this.id,
    this.categoryId,
    this.title,
    this.image,
    this.address,
    this.phone,
    this.coordX,
    this.coordY,
  });

  factory Sos.fromJson(Map<String, dynamic> json) {
    return Sos(
      id: json["id"],
      categoryId: json["categoryId"],
      title: json["title"],
      image: json["image"],
      address: json["address"],
      phone: json["phone"],
      coordX: json["coordX"],
      coordY: json["coordY"],
    );
  }
}
