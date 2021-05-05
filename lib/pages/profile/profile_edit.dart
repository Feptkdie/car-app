import 'dart:convert';
import 'dart:io';

import 'package:carpro_app/helpers/app_url.dart';
import 'package:carpro_app/helpers/user_preferences.dart';
import 'package:carpro_app/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';

class ProfileEdit extends StatefulWidget {
  static String routeName = "/profile_edit";
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  Future<User> _userPrefs;
  final formKey = new GlobalKey<FormState>();

  TextEditingController _lastNameController;
  TextEditingController _firstNameController;
  TextEditingController _phoneController;

  String _currentAvatar;

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void fetchData() {
    _userPrefs = UserPreferences().getUser();

    _lastNameController = TextEditingController();
    _firstNameController = TextEditingController();
    _phoneController = TextEditingController();

    _userPrefs.then((User user) {
      print("user: ${user.avatar}");

      _currentAvatar =
          (user.avatar == null || user.avatar == "") ? null : user.avatar;
      _lastNameController.text = user.lastname;
      _firstNameController.text = user.firstname;
      _phoneController.text = user.phone;
    }).catchError((err) {
      print(err);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
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
                FutureBuilder<User>(
                  future: _userPrefs,
                  builder:
                      (BuildContext context, AsyncSnapshot<User> snapshot) {
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
                          if (["", null, " ", false, 0]
                                  .contains(snapshot.data.token) &&
                              snapshot.data != null) {
                            return Center(child: Text("Нэвтрэх"));
                          } else {
                            return _info(height, width);
                          }
                        }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _info(double height, double width) => Column(
        children: <Widget>[
          _image == null
              ? _currentAvatar != null
                  ? Image.network(
                      _currentAvatar,
                      height: 100.0,
                      fit: BoxFit.cover,
                    )
                  : Text('Зураг')
              : Image.file(
                  _image,
                  height: 100.0,
                ),
          Container(
            width: 100.0,
            child: FlatButton(
              child: Icon(
                Icons.camera_alt,
                color: Colors.redAccent,
              ),
              onPressed: this.getImage,
              color: Colors.white,
            ),
            margin: EdgeInsets.only(top: 20.0),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _lastNameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Овог оруулна уу!';
                        }
                        if (value.length <= 2) {
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
                    width: double.infinity,
                    child: TextFormField(
                      controller: _firstNameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Нэрээ оруулна уу!';
                        }
                        if (value.length <= 2) {
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
                    width: double.infinity,
                    child: TextFormField(
                      controller: _phoneController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Утас дугаар оруулна уу!';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Утас',
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
                            String avatarImage;
                            String avatarName;

                            if (_image != null) {
                              List<int> imageBytes = _image.readAsBytesSync();
                              avatarImage = base64Encode(imageBytes);
                              avatarName = _image.path.split("/").last;
                            }

                            final Map<String, dynamic> formData = {
                              "lastname": _lastNameController.text,
                              "firstname": _firstNameController.text,
                              "phone": _phoneController.text,
                              "avatar": avatarImage,
                              "avatar_name": avatarName,
                            };

                            print("formdata: $formData");

                            var response = await http.post(
                              AppUrl.baseURL + "/update-user",
                              headers: {
                                "Authorization": "Bearer $token",
                                "Content-Type": "application/json",
                                "Accept": "application/json",
                              },
                              body: json.encode(formData),
                            );

                            // print(response.body);

                            if (response.statusCode == 200) {
                              var result =
                                  json.decode(utf8.decode(response.bodyBytes));

                              if (result["success"]) {
                                var user = {
                                  // "email": body["user"]["email"],
                                  "lastname": result["user"]["lastname"],
                                  "firstname": result["user"]["firstname"],
                                  "phone": result["user"]["phone"],
                                  "avatar": result["user"]["avatar"],
                                };

                                User authUser = User.fromJson(user);

                                UserPreferences().updateUser(authUser);
                                Navigator.popAndPushNamed(context, "/profile");
                              }
                            } else {
                              if (response.statusCode == 401) {
                                UserPreferences().removeUser();
                                Navigator.pushNamed(context, "/login");
                              } else {
                                Navigator.popAndPushNamed(context, "/profile");
                              }
                            }
                          }
                        } else {
                          UserPreferences().removeUser();
                          Navigator.pushNamed(context, "/login");
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
      );

  Widget _top(double height) {
    return Container(
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
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "Хувийн тохиргоо",
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
}
