import 'package:carpro_app/models/sos.dart';

class SosCategory {
  int id;
  String name;
  String image;
  List<Sos> soss;

  SosCategory({
    this.id,
    this.name,
    this.image,
    this.soss,
  });

  factory SosCategory.fromJson(Map<String, dynamic> json) {
    return SosCategory(
      id: json["id"],
      name: json["name"],
      image: json["image"],
      soss: json["soss"],
    );
  }
}
