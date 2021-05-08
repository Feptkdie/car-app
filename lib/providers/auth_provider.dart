import 'dart:convert';
import 'package:carpro_app/helpers/app_url.dart';
import 'package:carpro_app/helpers/user_preferences.dart';
import 'package:carpro_app/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

enum Status {
  NotRegistered,
  Registered,
  Registering,
  NotLoggedIn,
  LoggedIn,
  Authenticating,
  LoggedOut,
}

class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredStatus => _registeredStatus;

  Future<Map<String, dynamic>> register(
      String lastname, String firstname, String email, String password) async {
    final Map<String, dynamic> formData = {
      "lastname": lastname,
      "firstname": firstname,
      "email": email,
      "password": password,
      "phone": ""
    };

    _registeredStatus = Status.Registering;
    notifyListeners();

    var response = await http.post(
      AppUrl.signup,
      headers: {"Content-Type": "application/json"},
      body: json.encode(formData),
    );

    if (response.statusCode == 200) {
      var body = json.decode(response.body);

      var user = {
        "id": body["user"]["id"],
        "lastname": body["user"]["lastname"],
        "firstname": body["user"]["firstname"],
        "email": body["user"]["email"],
        "token": body["access_token"],
        "phone": body["user"]["phone"],
        "avatar": body["user"]["avatar"],
        "cars": json.encode(body["user"]["cars"]),
      };

      User authUser = User.fromJson(user);
      UserPreferences().saveUser(authUser);

      _registeredStatus = Status.Registered;
      notifyListeners();

      return {"success": body["success"]};
    } else {
      _registeredStatus = Status.NotRegistered;
      notifyListeners();

      return {
        "success": false,
        "statusCode": response.statusCode,
        "message": response.body
      };
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final Map<String, dynamic> formData = {
      "email": email,
      "password": password,
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    var response = await http.post(
      AppUrl.login,
      headers: {"Content-Type": "application/json"},
      body: json.encode(formData),
    );

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      var user = {
        "id": body["user"]["id"],
        "email": body["user"]["email"],
        "token": body["access_token"],
        "lastname": body["user"]["lastname"],
        "firstname": body["user"]["firstname"],
        "phone": body["user"]["phone"],
        "avatar": body["user"]["avatar"],
        "cars": json.encode(body["user"]["cars"]),
      };

      User authUser = User.fromJson(user);
      UserPreferences().saveUser(authUser);

      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      return {"success": true, "user": authUser};
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();

      return {"success": false};
    }
  }

  Future<Map<String, dynamic>> fbLogin(dynamic data, String token) async {
    var response = await http.post(
      AppUrl.baseURL + "/fb-login",
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      var body = json.decode(utf8.decode(response.bodyBytes));
      var user = {
        "id": body["id"]["S"],
        "email": body["email"]["S"],
        "token": token,
        "username": body["username"]["S"],
        "lastname": body["lastname"]["S"],
        "firstname": body["firstname"]["S"],
        "phone": body["phone"]["S"],
        "gender": body["gender"]["S"],
        "image": body["image"]["S"],
        "provider": body["provider"]["S"],
      };

      User authUser = User.fromJson(user);
      UserPreferences().saveUser(authUser);

      return {"success": true, "user": authUser};
    } else {
      return {"success": false, "message": "not found user"};
    }
  }
}
