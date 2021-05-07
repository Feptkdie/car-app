import 'dart:async';
import 'package:carpro_app/widgets/custom_app_bar.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carpro_app/providers/auth_provider.dart';
import '../../constants.dart';

class RegisterPage extends StatefulWidget {
  static String routeName = "/register";

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = new GlobalKey<FormState>();

  TextEditingController _lastnameController;
  TextEditingController _firstnameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _password2Controller;

  bool isEmail(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(email);
  }

  void initState() {
    super.initState();
    _lastnameController = TextEditingController();
    _firstnameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _password2Controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: kBackColor2,
      appBar: CustomAppBar(
        height: 56.0,
        title: "Бүртгүүлэх",
      ),
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
                    child: Form(
                      key: formKey,
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
                            child: TextFormField(
                              controller: _lastnameController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Овогоо оруулна уу!';
                                }
                                if (value.length <= 1) {
                                  return 'Үсгийн хэмжээ бага байна!';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Овог',
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: 250,
                            child: TextFormField(
                              controller: _firstnameController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Нэрээ оруулна уу!';
                                }
                                if (value.length <= 1) {
                                  return 'Үсгийн хэмжээ бага байна!';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Нэр',
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: 250,
                            child: TextFormField(
                              controller: _emailController,
                              validator: (value) {
                                if (value.isEmpty || !isEmail(value)) {
                                  return 'Мэйл хаягаа зөв оруулна уу!';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Мэйл хаяг',
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: 250,
                            child: TextFormField(
                              obscureText: true,
                              controller: _passwordController,
                              validator: (value) {
                                if (value.isEmpty || value.length <= 5) {
                                  return 'Таны нууц үг урт багадаа 6 байна';
                                }

                                if (value != _password2Controller.text) {
                                  return 'Нууц үг таарахгүй байна';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Нууц үг',
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: 250,
                            child: TextFormField(
                              obscureText: true,
                              controller: _password2Controller,
                              validator: (value) {
                                if (value.isEmpty || value.length <= 5) {
                                  return 'Таны нууц үгийн урт багадаа 6 байна';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Нууц үг давт',
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          SizedBox(
                            width: 250,
                            height: 40,
                            child: AbsorbPointer(
                              absorbing:
                                  auth.registeredStatus == Status.Registering
                                      ? true
                                      : false,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                color: kPrimaryColor.withOpacity(
                                    auth.registeredStatus == Status.Registering
                                        ? 0.6
                                        : 1),
                                padding: EdgeInsets.only(left: 5, right: 5),
                                onPressed: () {
                                  final form = formKey.currentState;

                                  if (form.validate()) {
                                    final Future<Map<String, dynamic>>
                                        responseResult = auth.register(
                                            _lastnameController.text,
                                            _firstnameController.text,
                                            _emailController.text,
                                            _passwordController.text);

                                    responseResult.then((data) {
                                      print(data);
                                      _lastnameController.text = "";
                                      _firstnameController.text = "";
                                      _emailController.text = "";
                                      _passwordController.text = "";
                                      _password2Controller.text = "";

                                      Navigator.popAndPushNamed(
                                          context, "/home");
                                      print(data);
                                      // if (data["success"]) {
                                      //   _showAlertRegisterFlash(
                                      //       "Бүртгэл амжилттай. Та одоо нэвтрэнэ үү!");

                                      //   Future.delayed(Duration(seconds: 3),
                                      //       () {
                                      //     Navigator.pushReplacementNamed(
                                      //         context, "/home");
                                      //   });
                                      // } else {
                                      //   print(data);
                                      //   if (data["statusCode"] == 400) {
                                      //     _showAlertRegisterFlash(
                                      //         "Мэйл хаяг бүртгэгдсэн байна!");
                                      //   } else {
                                      //     _showAlertRegisterFlash(
                                      //         "Хэрэглэгч бүртгэхэд алдаа гарлаа. Дахин оролдоно уу!");
                                      //   }
                                      // }
                                    });
                                  } else {
                                    _showAlertRegisterFlash(
                                        "Формоо зөв бөглөнө үү!");
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    if (auth.registeredStatus ==
                                        Status.Registering)
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
                                    if (auth.registeredStatus ==
                                        Status.Registering)
                                      SizedBox(width: 10),
                                    Text(
                                      "Бүртгүүлэх".toUpperCase(),
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
                          SizedBox(height: 25),
                          SizedBox(
                            width: 250,
                            height: 40,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              color: Colors.white,
                              padding: EdgeInsets.only(left: 5, right: 5),
                              onPressed: () {
                                Navigator.pushNamed(context, "/login");
                              },
                              child: Text(
                                "Нэвтрэх",
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: 250,
                            height: 40,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              color: Colors.white,
                              padding: EdgeInsets.only(left: 5, right: 5),
                              onPressed: () {
                                print("password forgot tapped");
                              },
                              child: Text(
                                "Нууц үгээ мартсан уу ?",
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
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

  void _showAlertRegisterFlash(String message) {
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
