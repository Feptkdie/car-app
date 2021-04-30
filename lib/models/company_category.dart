import 'package:carpro_app/models/company.dart';

class CompanyCategory {
  int id;
  String name;
  List<Company> companies;

  CompanyCategory({
    this.id,
    this.name,
    this.companies,
  });

  factory CompanyCategory.fromJson(Map<String, dynamic> json) {
    return CompanyCategory(
      id: json["id"],
      name: json["name"],
      companies: json["companies"],
    );
  }
}
