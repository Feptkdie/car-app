import 'package:car/constants.dart';
import 'package:car/helpers/app_preferences.dart';
import 'package:car/helpers/app_widgets.dart';
import 'package:flutter/material.dart';

class LoginFunction {
  static Future<Map<String, dynamic>> validLogin() {}
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final mailTEC = new TextEditingController();
  final passwordTEC = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Нэвтрэх"),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 30),
                        Container(
                          width: 250,
                          child: TextField(
                            controller: mailTEC,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Мэйл хаяг',
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 250,
                          child: TextField(
                            obscureText: true,
                            controller: passwordTEC,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              labelText: 'Нууц үг',
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Button(
                          borderRadius: 12.0,
                          height: 30.0,
                          width: 150.0,
                          fontSize: 18.0,
                          backgroundColor: kPrimaryColor,
                          splashColor: kPrimaryLightColor,
                          textColor: Colors.white,
                          text: "Нэвтрэх",
                          textBold: false,
                          onTap: () {
                            LoginFunction.validLogin();
                          },
                        ),
                        SizedBox(height: 30),
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
}
