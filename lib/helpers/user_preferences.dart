import '../models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await _prefs;

    prefs.setString("id", user.id);
    prefs.setString("email", user.email);
    prefs.setString("token", user.token);
    prefs.setString("username", user.username);
    prefs.setString("lastname", user.lastname);
    prefs.setString("firstname", user.firstname);
    prefs.setString("phone", user.phone);
    prefs.setString("gender", user.gender);
    prefs.setString("image", user.image);
    prefs.setString("provider", user.provider);
    prefs.setString("providerId", user.providerId);

    return true;
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await _prefs;

    String id = prefs.getString("id") ?? null;
    String email = prefs.getString("email") ?? null;
    String token = prefs.getString("token") ?? null;
    String username = prefs.getString("username") ?? null;
    String lastname = prefs.getString("lastname") ?? null;
    String firstname = prefs.getString("firstname") ?? null;
    String phone = prefs.getString("phone") ?? null;
    String gender = prefs.getString("gender") ?? null;
    String image = prefs.getString("image") ?? null;
    String provider = prefs.getString("provider") ?? null;
    String providerId = prefs.getString("providerId") ?? null;

    return User(
      id: id,
      email: email,
      token: token,
      username: username,
      lastname: lastname,
      firstname: firstname,
      phone: phone,
      gender: gender,
      image: image,
      provider: provider,
      providerId: providerId,
    );
  }

  void removeUser() async {
    final SharedPreferences prefs = await _prefs;

    prefs.remove("id");
    prefs.remove("email");
    prefs.remove("token");
    prefs.remove("username");
    prefs.remove("lastname");
    prefs.remove("firstname");
    prefs.remove("phone");
    prefs.remove("gender");
    prefs.remove("image");
    prefs.remove("provider");
    prefs.remove("providerId");
  }

  Future<List<String>> getToken() async {
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString("token") ?? null;
    String provider = prefs.getString("provider") ?? "jwt";
    return [token, provider];
  }

  Future<String> getEmail() async {
    final SharedPreferences prefs = await _prefs;
    String email = prefs.getString("email") ?? null;
    return email;
  }
}
