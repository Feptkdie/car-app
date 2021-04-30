class Car {
  int id;
  String name;
  List<dynamic> images;
  dynamic group;
  dynamic mark;
  dynamic model;
  String type;
  int importYear;
  int importMonth;
  int madeInYear;
  String engineCapacity;
  String drivderHand;
  int runningKm;
  String hutlugch;
  String hrop;
  String fuel;
  String description;
  int price;
  String phone;
  String seller;

  Car({
    this.id,
    this.name,
    this.images,
    this.group,
    this.mark,
    this.model,
    this.type,
    this.importYear,
    this.importMonth,
    this.madeInYear,
    this.engineCapacity,
    this.drivderHand,
    this.runningKm,
    this.hutlugch,
    this.hrop,
    this.fuel,
    this.description,
    this.price,
    this.phone,
    this.seller,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json["id"],
      name: json["name"],
      images: json["images"],
      group: json["group"],
      mark: json["mark"],
      model: json["model"],
      type: json["type"],
      importYear: json["importYear"],
      importMonth: json["importMonth"],
      madeInYear: json["madeInYear"],
      engineCapacity: json["engineCapacity"],
      drivderHand: json["drivderHand"],
      runningKm: json["runningKm"],
      hutlugch: json["hutlugch"],
      hrop: json["hrop"],
      fuel: json["fuel"],
      description: json["description"],
      price: json["price"],
      phone: json["phone"],
      seller: json["seller"],
    );
  }
}
