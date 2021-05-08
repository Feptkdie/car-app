import 'package:carpro_app/models/setting.dart';
import 'package:flutter/foundation.dart';

class SettingProvider with ChangeNotifier {
  List<Setting> _settings = new List<Setting>();
  List<Setting> get getSettings => _settings;

  void setSettings(List<Setting> list) {
    _settings = list;

    notifyListeners();
  }
}
