class AppUrl {
  static const String serverBaseUrl = "http://bombigo.xyz/api";
  static const String localBaseUrl = "http://127.0.0.1:8000/api";

  static const String baseURL = serverBaseUrl;
  static const String login = baseURL + "/login";
  static const String signup = baseURL + "/register";
  static const String forgotPassword = baseURL + "/forgot-password";
}
