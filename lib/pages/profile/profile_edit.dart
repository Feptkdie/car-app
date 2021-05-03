import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';

class ProfileEdit extends StatefulWidget {
  static String routeName = "/profile_edit";
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final firstNameTEC = new TextEditingController();
  final lastNameTEC = new TextEditingController();
  final phoneTEC = new TextEditingController();
  final islandTEC = new TextEditingController();
  final firstDateTEC = new TextEditingController();
  final lastDateTEC = new TextEditingController();
  final colorTEC = new TextEditingController();
  final carNameTEC = new TextEditingController();
  final carMarkTEC = new TextEditingController();
  final carNumberTEC = new TextEditingController();

  String _currentCategory = "Машин 1";
  bool _isLoad = true;
  @override
  void initState() {
    firstNameTEC.text = "Altankhuyag";
    lastNameTEC.text = "Bayarbileg";
    phoneTEC.text = "99115053";
    islandTEC.text = "YKP39";
    firstDateTEC.text = "2011";
    lastDateTEC.text = "2015";
    colorTEC.text = "Цагаан";
    carNameTEC.text = "PRIUS 30";
    carMarkTEC.text = "TOYOTA";
    carNumberTEC.text = "УБА 2424";
    setState(() {
      _isLoad = false;
    });
    super.initState();
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
                if (_isLoad)
                  Container(
                    height: height - height * 0.25,
                    width: double.infinity,
                    child: Center(
                      child: Container(
                        height: 15.0,
                        width: 15.0,
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1.8,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (!_isLoad) _info(height, width),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _info(double height, double width) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: height * 0.016,
                  ),
                  child: InkWell(
                    onTap: () {
                      print("profile!");
                    },
                    child: Text(
                      "Profile",
                      style: TextStyle(
                        color: kTextGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: height * 0.01,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      height * 0.2,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.black,
                        onTap: () {
                          //
                        },
                        child: Image.asset(
                          "assets/images/me.jpg",
                          fit: BoxFit.cover,
                          height: height * 0.14,
                          width: height * 0.14,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: height * 0.016,
                  ),
                  child: InkWell(
                    onTap: () {
                      //
                    },
                    child: Text(
                      "Зураг оруулах",
                      style: TextStyle(
                        color: kTextGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            top: height * 0.04,
            left: width * 0.06,
            right: width * 0.06,
            bottom: height * 0.02,
          ),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  isDense: true,
                  labelText: "Овог",
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                controller: firstNameTEC,
              ),
              SizedBox(
                height: height * 0.012,
              ),
              TextField(
                decoration: InputDecoration(
                  isDense: true,
                  labelText: "Нэр",
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                controller: lastNameTEC,
              ),
              SizedBox(
                height: height * 0.012,
              ),
              TextField(
                decoration: InputDecoration(
                  isDense: true,
                  labelText: "Утас",
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                keyboardType: TextInputType.phone,
                controller: phoneTEC,
              ),
              SizedBox(
                height: height * 0.04,
              ),
            ],
          ),
        ),
      ],
    );
  }

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
                        child: Theme.of(context).platform == TargetPlatform.iOS
                            ? Padding(
                                padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.045,
                                  width: MediaQuery.of(context).size.height *
                                      0.045,
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
                                  left:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.045,
                                  width: MediaQuery.of(context).size.height *
                                      0.045,
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
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(height * 0.2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black87,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(height * 0.2),
                        child: Material(
                          color: kTextGrey,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            splashColor: Colors.white,
                            child: Container(
                              height: height * 0.045,
                              width: height * 0.045,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  height * 0.2,
                                ),
                                border: Border.all(
                                  width: 2,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.done,
                                  color: Colors.white,
                                  size: height * 0.022,
                                ),
                              ),
                            ),
                          ),
                        ),
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
