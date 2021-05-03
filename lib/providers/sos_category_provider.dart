import 'package:carpro_app/models/sos_category.dart';
import 'package:flutter/foundation.dart';

class SosCategoryProvider with ChangeNotifier {
  List<SosCategory> _sosCategories = new List<SosCategory>();
  List<SosCategory> get getSosCategories => _sosCategories;

  SosCategory _filterCategorySos;
  SosCategory get getFilterCategorySos => _filterCategorySos;

  int _selectedCategoryId = 0;
  get getSelectedCategoryId => _selectedCategoryId;

  void setSosCategories(List<SosCategory> list) {
    _sosCategories = list;

    notifyListeners();

    if (list.length > 0) {
      findCategoryId(list[0].id);
    }
  }

  void findCategoryId(int categoryId) {
    _filterCategorySos = _sosCategories.firstWhere(
        (category) => category.id == categoryId,
        orElse: () => null);

    if (_filterCategorySos != null) {
      _selectedCategoryId = categoryId;
    }

    notifyListeners();
  }
}
