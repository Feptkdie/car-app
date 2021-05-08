import 'dart:convert';

import 'package:carpro_app/helpers/app_url.dart';
import 'package:carpro_app/helpers/user_preferences.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';

class AddCar extends StatefulWidget {
  static String routeName = "/add_car";
  @override
  _AddCarState createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  final formKey = new GlobalKey<FormState>();

  TextEditingController _nameController;
  TextEditingController _markNameController;
  TextEditingController _countryNumberController;

  String _curGroupName = "suudliin";

  List<Map<String, dynamic>> groupNames = [
    {"text": "Суудлын", "value": "suudliin"},
    {"text": "Ачааны", "value": "achaanii"},
    {"text": "Автобус", "value": "autobus"},
    {"text": "Хүнд ММ", "value": "hund_mm"},
    {"text": "Мотоцикл", "value": "motorcycle"},
  ];

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _markNameController = TextEditingController();
    _countryNumberController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackColor2,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: new LinearGradient(
                colors: [
                  kBackColor1,
                  kBackColor2,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _top(height),
                _info(height, width),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _info(double height, double width) => Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _curGroupName,
                      items: groupNames.map<DropdownMenuItem<String>>((map) {
                        return DropdownMenuItem<String>(
                          value: map["value"],
                          child: Text(map["text"].toString()),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _curGroupName = val;
                        });
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _markNameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Үйлдвэрлэгчээ оруулна уу!';
                        }
                        if (value.length <= 2) {
                          return 'Үсгийн хэмжээ бага байна!';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Үйлдвэрлэгч',
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Машины нэрээ оруулна уу!';
                        }
                        if (value.length <= 2) {
                          return 'Үсгийн хэмжээ бага байна!';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Машины нэр',
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _countryNumberController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Улсын дугаар оруулна уу!';
                        }
                        if (value.length <= 2) {
                          return 'Үсгийн хэмжээ бага байна!';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Улсын дугаар',
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(
                    width: 100.0,
                    height: 40,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: kTextGrey,
                      padding: EdgeInsets.only(left: 5, right: 5),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        String token = prefs.getString("token") ?? null;

                        if (token != null) {
                          final form = formKey.currentState;

                          if (form.validate()) {
                            final Map<String, dynamic> formData = {
                              "group_name": _curGroupName,
                              "name": _nameController.text,
                              "mark_name": _markNameController.text,
                              "country_number": _countryNumberController.text
                            };

                            var response = await http.post(
                              AppUrl.baseURL + "/profile-addcar",
                              headers: {
                                "Authorization": "Bearer $token",
                                "Content-Type": "application/json",
                                "Accept": "application/json",
                              },
                              body: json.encode(formData),
                            );

                            print(response.body);

                            if (response.statusCode == 200) {
                              var result =
                                  json.decode(utf8.decode(response.bodyBytes));

                              if (result["success"]) {
                                UserPreferences()
                                    .saveUserCars(json.encode(result["data"]));
                                Navigator.popAndPushNamed(context, "/profile");
                              }
                            } else {
                              if (response.statusCode == 401) {
                                Navigator.pushNamed(context, "/login");
                              } else {
                                Flushbar(
                                  margin: EdgeInsets.all(8),
                                  borderRadius: 8,
                                  message: "Error",
                                  duration: Duration(seconds: 4),
                                  icon: Icon(
                                    Icons.info_outline,
                                    size: 28.0,
                                    color: Colors.blue[300],
                                  ),
                                )..show(context);
                              }
                            }
                          }
                        } else {
                          UserPreferences().removeUser();
                          Navigator.pushNamed(context, "/login");
                        }
                      },
                      child: Text(
                        "Нэмэх",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  Widget _top(double height) => Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                right: height * 0.028,
                top: height * 0.006,
                bottom: height * 0.006,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(
                          8.0,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.01,
                            ),
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.045,
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
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        "Машин бүртгэх",
                        style: TextStyle(
                          color: kTextGrey,
                          fontWeight: FontWeight.bold,
                          fontSize: height * 0.028,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
