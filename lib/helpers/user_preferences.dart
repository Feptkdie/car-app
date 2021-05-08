import 'package:carpro_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await _prefs;

    prefs.setInt("id", user.id);
    prefs.setString("email", user.email);
    prefs.setString("token", user.token);
    prefs.setString("lastname", user.lastname);
    prefs.setString("firstname", user.firstname);
    prefs.setString("phone", user.phone);
    prefs.setString("avatar", user.avatar);
    prefs.setString("cars", user.cars);
    return true;
  }

  Future<bool> updateUser(User user) async {
    final SharedPreferences prefs = await _prefs;

    // prefs.setString("email", user.email);
    prefs.setString("lastname", user.lastname);
    prefs.setString("firstname", user.firstname);
    prefs.setString("phone", user.phone);
    prefs.setString("avatar", user.avatar);
    return true;
  }

  Future<bool> saveUserCars(String cars) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("cars", cars);
    return true;
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await _prefs;

    int id = prefs.getInt("id") ?? null;
    String email = prefs.getString("email") ?? null;
    String token = prefs.getString("token") ?? null;
    String lastname = prefs.getString("lastname") ?? null;
    String firstname = prefs.getString("firstname") ?? null;
    String phone = prefs.getString("phone") ?? null;
    String avatar = prefs.getString("avatar") ?? null;
    String cars = prefs.getString("cars") ?? null;

    return User(
      id: id,
      email: email,
      token: token,
      lastname: lastname,
      firstname: firstname,
      phone: phone,
      avatar: avatar,
      cars: cars,
    );
  }

  void removeUser() async {
    final SharedPreferences prefs = await _prefs;

    prefs.remove("id");
    prefs.remove("email");
    prefs.remove("token");
    prefs.remove("lastname");
    prefs.remove("firstname");
    prefs.remove("phone");
    prefs.remove("avatar");
    prefs.remove("cars");
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString("token") ?? null;
    return token;
  }

  Future<String> getEmail() async {
    final SharedPreferences prefs = await _prefs;
    String email = prefs.getString("email") ?? null;
    return email;
  }
}
