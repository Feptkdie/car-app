import 'dart:convert';
import 'package:carpro_app/helpers/user_preferences.dart';
import 'package:carpro_app/widgets/custom_app_bar.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class AddPart extends StatefulWidget {
  static String routeName = "/add_part";
  @override
  _AddPartState createState() => _AddPartState();
}

class _AddPartState extends State<AddPart> {
  final formKey = new GlobalKey<FormState>();

  int _userCarId = 0;

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
        title: "Эд анги нэмэх",
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
                        labelText: "Эд ангийн нэр",
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
                        labelText: "Худалдаж авсан он сар",
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
                      maxLines: 2,
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
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: kColor3,
                      padding: EdgeInsets.only(left: 5, right: 5),
                      onPressed: () async {
                        UserPreferences().getToken().then((token) {
                          if (token != null) {
                            final form = formKey.currentState;

                            if (form.validate()) {
                              final _userCarId =
                                  ModalRoute.of(context).settings.arguments;

                              final Map<String, dynamic> formData = {
                                "user_car_id": _userCarId,
                                "name": _nameController.text,
                                "purchased_at": _purchasedAtController.text,
                                "replaced_at": _replacedAtController.text,
                                "description": _descriptionController.text,
                              };

                              print(formData);

                              // var response = await http.post(
                              //   AppUrl.baseURL + "/profile-addcar",
                              //   headers: {
                              //     "Authorization": "Bearer $token",
                              //     "Content-Type": "application/json",
                              //     "Accept": "application/json",
                              //   },
                              //   body: json.encode(formData),
                              // );

                              // print(response.body);

                              // if (response.statusCode == 200) {
                              //   var result = json
                              //       .decode(utf8.decode(response.bodyBytes));

                              //   if (result["success"]) {
                              //     UserPreferences().saveUserCars(
                              //         json.encode(result["data"]));
                              //     Navigator.popAndPushNamed(
                              //         context, "/profile_car_edit");
                              //   }
                              // } else {
                              //   if (response.statusCode == 401) {
                              //     Navigator.pushNamed(context, "/login");
                              //   } else {
                              //     Flushbar(
                              //       margin: EdgeInsets.all(8),
                              //       borderRadius: 8,
                              //       message: "Error",
                              //       duration: Duration(seconds: 4),
                              //       icon: Icon(
                              //         Icons.info_outline,
                              //         size: 28.0,
                              //         color: Colors.blue[300],
                              //       ),
                              //     )..show(context);
                              //   }
                              // }
                            }
                          } else {
                            UserPreferences().removeUser();
                            Navigator.pushNamed(context, "/login");
                          }
                        }).catchError((err) {
                          print(err);
                          UserPreferences().removeUser();
                          Navigator.pushNamed(context, "/login");
                        });
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
        ),
      ),
    );
  }

  // Widget _info(double height, double width) => Column(
  //       children: <Widget>[
  //         Padding(
  //           padding: EdgeInsets.only(
  //             top: height * 0.04,
  //             left: width * 0.06,
  //             right: width * 0.06,
  //             bottom: height * 0.02,
  //           ),
  //           child: Column(
  //             children: <Widget>[
  //               TextField(
  //                 decoration: InputDecoration(
  //                   isDense: true,
  //                   labelText: "Эд ангийн нэр",
  //                   labelStyle: TextStyle(
  //                     color: Colors.grey,
  //                   ),
  //                 ),
  //                 controller: partNameTEC,
  //               ),
  //               SizedBox(
  //                 height: height * 0.012,
  //               ),
  //               TextField(
  //                 decoration: InputDecoration(
  //                   isDense: true,
  //                   labelText: "Авсан он сар",
  //                   labelStyle: TextStyle(
  //                     color: Colors.grey,
  //                   ),
  //                 ),
  //                 controller: partStartAtTEC,
  //               ),
  //               SizedBox(
  //                 height: height * 0.012,
  //               ),
  //               TextField(
  //                 decoration: InputDecoration(
  //                   isDense: true,
  //                   labelText: "Солисон он сар",
  //                   labelStyle: TextStyle(
  //                     color: Colors.grey,
  //                   ),
  //                 ),
  //                 keyboardType: TextInputType.phone,
  //                 controller: partFixAtTEC,
  //               ),
  //               SizedBox(
  //                 height: height * 0.012,
  //               ),
  //               TextField(
  //                 decoration: InputDecoration(
  //                   isDense: true,
  //                   labelText: "Нэмэлт мэдээлэл",
  //                   labelStyle: TextStyle(
  //                     color: Colors.grey,
  //                   ),
  //                 ),
  //                 controller: commentTEC,
  //               ),
  //               SizedBox(
  //                 height: height * 0.04,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     );
}
