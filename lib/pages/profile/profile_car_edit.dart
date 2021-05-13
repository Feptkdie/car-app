import 'dart:convert';
import 'dart:io';

import 'package:carpro_app/helpers/app_url.dart';
import 'package:carpro_app/helpers/user_preferences.dart';
import 'package:carpro_app/models/user.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

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
  TextEditingController _color;

  String _carStringList;
  String _curGroupName = "suudliin";
  String _curCoverImage;

  String _selectedCarId;

  File _image;
  final picker = ImagePicker();

  Future getImageCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  List<Map<String, dynamic>> groupNames = [
    {"text": "Суудлын", "value": "suudliin"},
    {"text": "Ачааны", "value": "achaanii"},
    {"text": "Автобус", "value": "autobus"},
    {"text": "Хүнд ММ", "value": "hund_mm"},
    {"text": "Мотоцикл", "value": "motorcycle"},
  ];

  void fetchData() {
    _userPrefs = UserPreferences().getUser();

    _nameController = TextEditingController();
    _markNameController = TextEditingController();
    _countryNumberController = TextEditingController();
    _color = TextEditingController();

    _userPrefs.then((User user) {
      print("user: $user");
      _carStringList = user.cars;
      var carList = json.decode(_carStringList);
      if (carList.length > 0) {
        _selectedCarId = carList[0]["id"].toString();
        _curCoverImage = carList[0]["cover"];
        _curGroupName = carList[0]["group_name"];
        _nameController.text = carList[0]["name"];
        _markNameController.text = carList[0]["mark_name"];
        _countryNumberController.text = carList[0]["country_number"];
        _color.text = carList[0]["color"];
      }
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
    print("mounted page");
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
        title: Text(
          "Машины тохиргоо",
          style: TextStyle(
            color: kTextGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            color: kColor3,
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.popAndPushNamed(context, "/add_car");
            },
          ),
        ],
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
                  var carList = json.decode(_carStringList);

                  print(carList.length);

                  return SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
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

                                      var findCarId = carList.firstWhere(
                                          (car) => car["id"].toString() == val,
                                          orElse: () => null);

                                      if (findCarId != null) {
                                        _curCoverImage = findCarId["cover"];
                                        _curGroupName = findCarId["group_name"];
                                        _nameController.text =
                                            findCarId["name"];
                                        _markNameController.text =
                                            findCarId["mark_name"];
                                        _countryNumberController.text =
                                            findCarId["country_number"];
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                          if (carList.length > 0)
                            Container(
                              padding: EdgeInsets.all(20.0),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    _image == null
                                        ? _curCoverImage != null
                                            ? Image.network(
                                                _curCoverImage,
                                                height: 100.0,
                                                fit: BoxFit.cover,
                                              )
                                            : Text('No image selected.')
                                        : Image.file(
                                            _image,
                                            height: 100.0,
                                          ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        Container(
                                          width: 100.0,
                                          child: FlatButton(
                                            child: Icon(
                                              Icons.camera_alt,
                                              color: Colors.redAccent,
                                            ),
                                            onPressed: this.getImageCamera,
                                            color: Colors.white,
                                          ),
                                          margin: EdgeInsets.only(top: 20.0),
                                        ),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        Container(
                                          width: 100.0,
                                          child: FlatButton(
                                            child: Icon(
                                              Icons.image,
                                              color: Colors.redAccent,
                                            ),
                                            onPressed: this.getImageGallery,
                                            color: Colors.white,
                                          ),
                                          margin: EdgeInsets.only(top: 20.0),
                                        ),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                      ],
                                    ),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        value: _curGroupName,
                                        items: groupNames
                                            .map<DropdownMenuItem<String>>(
                                                (map) {
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
                                    SizedBox(height: 10),
                                    Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller: _color,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Өнгө оруулна уу!';
                                          }
                                          if (value.length <= 2) {
                                            return 'Үсгийн хэмжээ бага байна!';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Өнгө',
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20.0),
                                    Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 100.0,
                                          height: 40,
                                          child: FlatButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            color: kTextGrey,
                                            padding: EdgeInsets.only(
                                                left: 5, right: 5),
                                            onPressed: () async {
                                              var token = snapshot.data.token;

                                              if (token != null) {
                                                final form =
                                                    formKey.currentState;

                                                if (form.validate()) {
                                                  String coverImage;
                                                  String coverName;

                                                  if (_image != null) {
                                                    List<int> imageBytes =
                                                        _image
                                                            .readAsBytesSync();
                                                    coverImage = base64Encode(
                                                        imageBytes);
                                                    coverName = _image.path
                                                        .split("/")
                                                        .last;
                                                  }

                                                  final Map<String, dynamic>
                                                      formData = {
                                                    "group_name": _curGroupName,
                                                    "name":
                                                        _nameController.text,
                                                    "mark_name":
                                                        _markNameController
                                                            .text,
                                                    "country_number":
                                                        _countryNumberController
                                                            .text,
                                                    "cover": coverImage,
                                                    "cover_name": coverName,
                                                  };

                                                  print(formData);

                                                  var response = await http.put(
                                                    AppUrl.baseURL +
                                                        "/profile-editcar/$_selectedCarId",
                                                    headers: {
                                                      "Authorization":
                                                          "Bearer $token",
                                                      "Content-Type":
                                                          "application/json",
                                                      "Accept":
                                                          "application/json",
                                                    },
                                                    body: json.encode(formData),
                                                  );

                                                  if (response.statusCode ==
                                                      200) {
                                                    var result = json.decode(
                                                        utf8.decode(response
                                                            .bodyBytes));

                                                    print(result);

                                                    if (result["success"]) {
                                                      print(result["data"]);

                                                      UserPreferences()
                                                          .saveUserCars(json
                                                              .encode(result[
                                                                  "data"]));

                                                      Flushbar(
                                                        margin:
                                                            EdgeInsets.all(8),
                                                        borderRadius: 8,
                                                        message:
                                                            "Амжилттай хадгалагдлаа",
                                                        duration: Duration(
                                                            seconds: 3),
                                                        icon: Icon(
                                                          Icons.info_outline,
                                                          size: 28.0,
                                                          color:
                                                              Colors.blue[300],
                                                        ),
                                                      )..show(context);

                                                      // setState(() {
                                                      //   _image = null;
                                                      //   _carStringList =
                                                      //       json.encode(
                                                      //           result["data"]);
                                                      // });
                                                      Navigator.popAndPushNamed(
                                                          context, "/profile");
                                                    }
                                                  } else {
                                                    print(response.statusCode);
                                                    print(response.body);

                                                    if (response.statusCode ==
                                                        401) {
                                                      UserPreferences()
                                                          .removeUser();
                                                      Navigator.pushNamed(
                                                          context, "/login");
                                                    } else {
                                                      Flushbar(
                                                        margin:
                                                            EdgeInsets.all(8),
                                                        borderRadius: 8,
                                                        message: "Error",
                                                        duration: Duration(
                                                            seconds: 4),
                                                        icon: Icon(
                                                          Icons.info_outline,
                                                          size: 28.0,
                                                          color:
                                                              Colors.blue[300],
                                                        ),
                                                      )..show(context);
                                                    }
                                                  }
                                                }
                                              } else {
                                                UserPreferences().removeUser();
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
                                        Spacer(),
                                        SizedBox(
                                          width: 80.0,
                                          height: 40,
                                          child: FlatButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            color: kBackColor1,
                                            padding: EdgeInsets.only(
                                                left: 5, right: 5),
                                            onPressed: () async {
                                              _showDeleteDialog(
                                                  context,
                                                  snapshot.data.token,
                                                  _nameController.text);
                                            },
                                            child: Text(
                                              "Устгах",
                                              style: TextStyle(
                                                color: kColor1,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
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

  Future<void> _showDeleteDialog(
      BuildContext ctx, String token, String carName) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Анхааруулга"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("$carName машины мэдээлэлийг устгахад итгэлтэй байна уу?"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Үгүй"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Тийм",
                style: TextStyle(color: kColor1),
              ),
              onPressed: () async {
                Navigator.of(context).pop();

                var response = await http.delete(
                    AppUrl.baseURL + "/profile-deletecar/$_selectedCarId",
                    headers: {
                      "Authorization": "Bearer $token",
                      "Content-Type": "application/json",
                      "Accept": "application/json",
                    });

                if (response.statusCode == 200) {
                  var result = json.decode(utf8.decode(response.bodyBytes));

                  if (result["success"]) {
                    print(result["data"]);
                    UserPreferences().saveUserCars(json.encode(result["data"]));
                    Flushbar(
                      margin: EdgeInsets.all(8),
                      borderRadius: 8,
                      message: "Амжилттай устгагдлаа",
                      duration: Duration(seconds: 3),
                      icon: Icon(
                        Icons.info_outline,
                        size: 28.0,
                        color: Colors.blue[300],
                      ),
                    )..show(ctx);

                    // setState(() {
                    //   fetchData();
                    //   // _carStringList = json.encode(result["data"]);
                    // });
                    Navigator.popAndPushNamed(ctx, "/profile");
                  }
                } else {
                  print(response.body);

                  if (response.statusCode == 401) {
                    UserPreferences().removeUser();
                    Navigator.pushNamed(ctx, "/login");
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
                    )..show(ctx);
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }
}
