import 'dart:convert';

import 'package:carpro_app/helpers/user_preferences.dart';
import 'package:carpro_app/models/user.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class ProfileCarEdit extends StatefulWidget {
  static String routeName = "/profile_car_edit";

  @override
  _ProfileCarEditState createState() => _ProfileCarEditState();
}

class _ProfileCarEditState extends State<ProfileCarEdit> {
  Future<User> _userPrefs;

  final formKey = new GlobalKey<FormState>();
  TextEditingController _nameController;
  TextEditingController _markNameController;
  TextEditingController _countryNumberController;

  String _selectedCarId;

  @override
  void initState() {
    super.initState();
    _userPrefs = UserPreferences().getUser();

    _nameController = TextEditingController();
    _markNameController = TextEditingController();
    _countryNumberController = TextEditingController();

    _userPrefs.then((User user) {
      print("user: $user");
      var carList = json.decode(user.cars);
      if (carList.length > 0) {
        _selectedCarId = carList[0]["id"].toString();
        _nameController.text = carList[0]["name"];
        _markNameController.text = carList[0]["mark_name"];
        _countryNumberController.text = carList[0]["country_number"];
      }
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackColor2,
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
          "Машины тохиргоо",
          style: TextStyle(
            color: kTextGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<User>(
        future: _userPrefs,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: Text("Уншиж байна ..."),
              );
            default:
              if (snapshot.hasError) {
                // return Text("Error: ${snapshot.error}");
                return Center(child: Text("Нэвтрэх"));
              } else {
                if (["", null, " ", false, 0].contains(snapshot.data.token) &&
                    snapshot.data != null) {
                  return Center(child: Text("Нэвтрэх"));
                } else {
                  // print(snapshot.data.cars);
                  var carList = json.decode(snapshot.data.cars);

                  return SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: FlatButton(
                              color: kColor3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text(
                                "Машин нэмэх",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, "/add_car");
                              },
                            ),
                          ),
                          if (carList.length > 0)
                            Container(
                              margin: EdgeInsets.all(20),
                              color: kBackColor1,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: _selectedCarId,
                                  items: carList
                                      .map<DropdownMenuItem<String>>((map) {
                                    return DropdownMenuItem<String>(
                                      value: map["id"].toString(),
                                      child: Text(map["name"].toString()),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      _selectedCarId = val;

                                      print("val: $val");

                                      var findCarId = carList.firstWhere(
                                          (car) => car["id"].toString() == val,
                                          orElse: () => null);

                                      if (findCarId != null) {
                                        _nameController.text =
                                            findCarId["name"];
                                        _markNameController.text =
                                            findCarId["mark_name"];
                                        _countryNumberController.text =
                                            findCarId["country_number"];
                                      }
                                      print(findCarId);

                                      // _curGroupName = val;
                                    });
                                  },
                                ),
                              ),
                            ),
                          Container(
                            padding: EdgeInsets.all(20.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  // ClipRRect(
                                  //   borderRadius: BorderRadius.circular(35),
                                  //   child: Image.asset(
                                  //     "assets/images/child.png",
                                  //     width: 70,
                                  //   ),
                                  // ),
                                  // SizedBox(height: 30),
                                  // DropdownButtonHideUnderline(
                                  //   child: DropdownButton<String>(
                                  //     isExpanded: true,
                                  //     value: _curGroupName,
                                  //     items: groupNames
                                  //         .map<DropdownMenuItem<String>>((map) {
                                  //       return DropdownMenuItem<String>(
                                  //         value: map["value"],
                                  //         child: Text(map["text"].toString()),
                                  //       );
                                  //     }).toList(),
                                  //     onChanged: (val) {
                                  //       setState(() {
                                  //         _curGroupName = val;
                                  //       });
                                  //     },
                                  //   ),
                                  // ),
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
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      color: kTextGrey,
                                      padding:
                                          EdgeInsets.only(left: 5, right: 5),
                                      onPressed: () async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        String token =
                                            prefs.getString("token") ?? null;

                                        if (token != null) {
                                          final form = formKey.currentState;

                                          if (form.validate()) {
                                            // final Map<String, dynamic>
                                            //     formData = {
                                            //   "group_name": _curGroupName,
                                            //   "name": _nameController.text,
                                            //   "mark_name":
                                            //       _markNameController.text,
                                            //   "country_number":
                                            //       _countryNumberController.text
                                            // };

                                            // var response = await http.post(
                                            //   AppUrl.baseURL +
                                            //       "/profile-addcar",
                                            //   headers: {
                                            //     "Authorization":
                                            //         "Bearer $token",
                                            //     "Content-Type":
                                            //         "application/json",
                                            //     "Accept": "application/json",
                                            //   },
                                            //   body: json.encode(formData),
                                            // );

                                            // if (response.statusCode == 200) {
                                            //   var result = json.decode(utf8
                                            //       .decode(response.bodyBytes));

                                            //   if (result["success"]) {
                                            //     UserPreferences().saveUserCars(
                                            //         json.encode(
                                            //             result["data"]));
                                            //     Navigator.pushNamed(context,
                                            //         "/profile_car_edit");
                                            //   }
                                            // } else {
                                            //   if (response.statusCode == 401) {
                                            //     Navigator.pushNamed(
                                            //         context, "/login");
                                            //   } else {
                                            //     Flushbar(
                                            //       margin: EdgeInsets.all(8),
                                            //       borderRadius: 8,
                                            //       message: "Error",
                                            //       duration:
                                            //           Duration(seconds: 4),
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
                                          Navigator.pushNamed(
                                              context, "/login");
                                        }
                                      },
                                      child: Text(
                                        "Хадгалах",
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
                      ),
                    ),
                  );
                }
              }
          }
        },
      ),
    );
  }
}
