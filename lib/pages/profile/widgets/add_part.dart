import 'dart:convert';
import 'package:carpro_app/helpers/app_url.dart';
import 'package:carpro_app/helpers/user_preferences.dart';
import 'package:carpro_app/widgets/custom_app_bar.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_indicator_button/progress_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';

class AddPart extends StatefulWidget {
  static String routeName = "/add_part";
  @override
  _AddPartState createState() => _AddPartState();
}

class _AddPartState extends State<AddPart> {
  final formKey = new GlobalKey<FormState>();

  TextEditingController _nameController;
  TextEditingController _purchasedAtController;
  TextEditingController _replacedAtController;
  TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _purchasedAtController = TextEditingController();
    _replacedAtController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    print(ModalRoute.of(context).settings.arguments);

    return Scaffold(
      backgroundColor: kBackColor2,
      appBar: CustomAppBar(
        height: 56.0,
        title: "Үйлчилгээ бүртгэх",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Хоосон байна!";
                        }
                        if (value.length <= 2) {
                          return "Үсгийн хэмжээ бага байна!";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Үйлчилгээний нэр",
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _purchasedAtController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Хоосон байна!";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Эхлэх он сар",
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _replacedAtController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Хоосон байна!";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Солисон он сар",
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _descriptionController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Хоосон байна!";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Нэмэлт тайлбар",
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  SizedBox(
                    width: 80.0,
                    height: 36.0,
                    child: ProgressButton(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      strokeWidth: 2,
                      color: kColor3,
                      progressIndicatorSize: 20,
                      child: Text(
                        "Бүртгэх",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                      onPressed: (AnimationController controller) async {
                        controller.forward();

                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        String token = prefs.getString("token") ?? null;

                        if (token != null) {
                          final form = formKey.currentState;

                          if (form.validate()) {
                            if (!controller.isCompleted) {
                              final _userCarId =
                                  ModalRoute.of(context).settings.arguments;

                              final Map<String, dynamic> formData = {
                                "user_car_id": _userCarId,
                                "name": _nameController.text,
                                "purchased_at": _purchasedAtController.text,
                                "replaced_at": _replacedAtController.text,
                                "description": _descriptionController.text,
                              };

                              var response = await http.post(
                                AppUrl.baseURL + "/add-part",
                                headers: {
                                  "Authorization": "Bearer $token",
                                  "Content-Type": "application/json",
                                  "Accept": "application/json",
                                },
                                body: json.encode(formData),
                              );

                              if (response.statusCode == 200) {
                                controller.reset();

                                var result = json
                                    .decode(utf8.decode(response.bodyBytes));

                                if (result["success"]) {
                                  UserPreferences().saveUserCars(
                                      json.encode(result["data"]));
                                  Navigator.popAndPushNamed(
                                      context, "/profile");
                                }
                              } else {
                                controller.reset();
                                if (response.statusCode == 401) {
                                  UserPreferences().removeUser();
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
                            controller.reset();
                          }
                        } else {
                          controller.reset();
                          UserPreferences().removeUser();
                          Navigator.pushNamed(context, "/login");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
