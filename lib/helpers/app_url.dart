class AppUrl {
  static const String serverBaseUrl = "https://1bb0e4f3cbc9.ngrok.io/api";
  static const String localBaseUrl = "http://127.0.0.1:8000/api";

  static const String baseURL = serverBaseUrl;
  static const String login = baseURL + "/login";
  static const String signup = baseURL + "/signup";
  static const String forgotPassword = baseURL + "/forgot-password";
}
