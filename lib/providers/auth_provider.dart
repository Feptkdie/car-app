import 'dart:convert';

import '../helpers/app_url.dart';
import '../helpers/user_preferences.dart';
import '../models/user.dart';
import 'package:flutter/material.dart';
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
      String username, String email, String password) async {
    final Map<String, dynamic> formData = {
      "username": username,
      "email": email,
      "password": password,
    };

    _registeredStatus = Status.Registering;
    notifyListeners();

    var response = await http.post(
      AppUrl.signup,
      headers: {"Content-Type": "application/json"},
      body: json.encode(formData),
    );

    if (response.statusCode == 201) {
      var body = json.decode(response.body);

      // var user = {
      //   "id": body["user"]["id"]["S"],
      //   "username": body["user"]["username"]["S"],
      //   "email": body["user"]["email"]["S"],
      //   "token": body["user"]["token"],
      //   "provider": body["user"]["provider"]["S"],
      //   "providerId": body["user"]["provider_id"]["S"],
      //   "gender": body["user"]["gender"]["S"],
      //   "phone": body["user"]["phone"]["S"],
      //   "image": body["user"]["image"]["S"],
      //   "lastname": body["user"]["lastname"]["S"],
      //   "firstname": body["user"]["firstname"]["S"],
      // };

      // User authUser = User.fromJson(user);
      // UserPreferences().saveUser(authUser);

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
        "username": body["user"]["username"],
        "email": body["user"]["email"],
        "token": body["user"]["token"],
        "provider": body["user"]["provider"],
        "providerId": body["user"]["provider_id"],
        "gender": body["user"]["gender"],
        "phone": body["user"]["phone"],
        "image": body["user"]["image"],
        "lastname": body["user"]["lastname"],
        "firstname": body["user"]["firstname"],
      };

      User authUser = User.fromJson(user);
      UserPreferences().saveUser(authUser);

      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      return {"success": body["success"], "user": authUser};
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();

      return {"success": false};
    }
  }
}
