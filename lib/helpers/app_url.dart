class AppUrl {
  static const String serverBaseUrl =
      "https://v269mh6ua4.execute-api.ap-southeast-1.amazonaws.com/v1";
  static const String localBaseUrl = "http://192.168.1.9:8000/api";

  static const String baseURL = serverBaseUrl;
  static const String login = baseURL + "/login";
  static const String signup = baseURL + "/signup";
  static const String forgotPassword = baseURL + "/forgot-password";
}
