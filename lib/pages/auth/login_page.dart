import 'dart:async';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:carpro_app/providers/auth_provider.dart';
import '../../constants.dart';

class LoginPage extends StatefulWidget {
  static String routeName = "/login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController;
  TextEditingController _passwordController;

  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackColor2,
        leading: Padding(
          padding: const EdgeInsets.all(
            6.0,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop(context);
            },
            child: Theme.of(context).platform == TargetPlatform.iOS
                ? Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.01,
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.045,
                      width: MediaQuery.of(context).size.height * 0.045,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Colors.red[500],
                            Colors.red[900],
                          ],
                        ),
                      ),
                      child: CupertinoButton(
                        color: Colors.transparent,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.01,
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.045,
                      width: MediaQuery.of(context).size.height * 0.045,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Colors.red[500],
                            Colors.red[900],
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black87,
                            blurRadius: 7,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
          ),
        ),
        title: Text(
          "Нэвтрэх",
          style: TextStyle(
            color: kTextGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: kBackColor2,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (ctx, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Center(
                  child: Container(
                    // color: Colors.red,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(35),
                          child: Image.asset(
                            "assets/images/logo_one.png",
                            width: 70,
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          width: 250,
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Мэйл хаяг',
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: 250,
                          child: TextField(
                            obscureText: true,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: 'Нууц үг',
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        SizedBox(
                          width: 250,
                          height: 40,
                          child: AbsorbPointer(
                            absorbing:
                                auth.loggedInStatus == Status.Authenticating
                                    ? true
                                    : false,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              color: kPrimaryColor.withOpacity(
                                  auth.loggedInStatus == Status.Authenticating
                                      ? 0.6
                                      : 1),
                              padding: EdgeInsets.only(left: 5, right: 5),
                              onPressed: () {
                                // Login submit
                                if (isEmptyForm()) {
                                  _showAlertLoginFlash(
                                      "Мэйл хаяг эсвэл нууц үг буруу байна");
                                } else {
                                  final Future<Map<String, dynamic>>
                                      responseResult = auth.login(
                                          _emailController.text,
                                          _passwordController.text);

                                  responseResult.then((data) {
                                    if (data["success"]) {
                                      Navigator.pushReplacementNamed(
                                          context, "/home");
                                    } else {
                                      _emailController.text = "";
                                      _passwordController.text = "";
                                      _showAlertLoginFlash(
                                          "Мэйл хаяг эсвэл нууц үг буруу байна");
                                    }
                                  });
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  if (auth.loggedInStatus ==
                                      Status.Authenticating)
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.0,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Colors.white,
                                        ),
                                      ),
                                    ),
                                  if (auth.loggedInStatus ==
                                      Status.Authenticating)
                                    SizedBox(width: 10),
                                  Text(
                                    "Нэвтрэх".toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(height: 80),
                        // SizedBox(
                        //   width: 250,
                        //   height: 40,
                        //   child: FlatButton(
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(20.0),
                        //     ),
                        //     color: Colors.white,
                        //     padding: EdgeInsets.only(left: 5, right: 5),
                        //     onPressed: () {
                        //       Navigator.pushNamed(context, "/register");
                        //     },
                        //     child: Text(
                        //       "Бүртгүүлэх",
                        //       style: TextStyle(
                        //         color: Colors.black.withOpacity(0.7),
                        //         fontWeight: FontWeight.bold,
                        //         fontSize: 13,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(height: 10),
                        // SizedBox(
                        //   width: 250,
                        //   height: 40,
                        //   child: FlatButton(
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(20.0),
                        //     ),
                        //     color: Colors.white,
                        //     padding: EdgeInsets.only(left: 5, right: 5),
                        //     onPressed: () async {
                        //       var response = await http
                        //           .get(AppUrl.baseURL + "/forgot-password");

                        //       print(response.body);
                        //     },
                        //     child: Text(
                        //       "Нууц үгээ мартсан уу ?",
                        //       style: TextStyle(
                        //         color: Colors.black.withOpacity(0.7),
                        //         fontWeight: FontWeight.bold,
                        //         fontSize: 13,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  bool isEmptyForm() {
    if (_emailController.text == null ||
        _emailController.text.isEmpty ||
        _passwordController.text == null ||
        _passwordController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void _showAlertLoginFlash(String message) {
    Flushbar(
      margin: EdgeInsets.all(8),
      borderRadius: 8,
      message: message,
      duration: Duration(seconds: 4),
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.blue[300],
      ),
    )..show(context);
  }
}
