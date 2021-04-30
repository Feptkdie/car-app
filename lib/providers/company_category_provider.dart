import 'package:carpro_app/models/company_category.dart';
import 'package:flutter/foundation.dart';

class CompanyCategoryProvider with ChangeNotifier {
  List<CompanyCategory> _companyCategories = new List<CompanyCategory>();
  List<CompanyCategory> get getCompanyCategories => _companyCategories;

  void setCompanyCategories(List<CompanyCategory> list) {
    _companyCategories = list;

    notifyListeners();
  }
}
