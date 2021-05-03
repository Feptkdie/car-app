import 'package:carpro_app/models/car.dart';
import 'package:flutter/foundation.dart';

class CarProvider with ChangeNotifier {
  List<Car> _cars = new List<Car>();
  List<Car> get getCars => _cars;

  Car _car;
  Car get getCar => _car;

  void setCars(List<Car> list) {
    _cars = list;

    notifyListeners();
  }

  void findId(int carId) {
    _car = _cars.firstWhere((info) => info.id == carId, orElse: () => null);
    notifyListeners();
  }
}
