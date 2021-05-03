import 'package:carpro_app/models/info.dart';
import 'package:flutter/foundation.dart';

class InfoProvider with ChangeNotifier {
  List<Info> _infos = new List<Info>();
  List<Info> get getInfos => _infos;

  void setSoss(List<Info> list) {
    _infos = list;

    notifyListeners();
  }
}
