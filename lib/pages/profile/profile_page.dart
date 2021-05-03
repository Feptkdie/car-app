import 'package:carpro_app/helpers/user_preferences.dart';
import 'package:carpro_app/models/user.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import '../../constants.dart';

class ProfilePage extends StatefulWidget {
  static String routeName = "/profile";
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<User> _userPrefs;
  bool isLogged = false;

  @override
  void initState() {
    super.initState();

    _userPrefs = UserPreferences().getUser();

    _userPrefs.then((User user) {
      if (user.token == null) {
        isLogged = false;
        Navigator.pushReplacementNamed(context, "/login");
      } else {
        setState(() {
          isLogged = true;
        });
      }
    }).catchError((err) {
      print(err);
      isLogged = false;
      Navigator.pushReplacementNamed(context, "/login");
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    if (!isLogged) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Text("Loading ..."),
          ),
        ),
      );
    } else {
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
  }

  Widget _info(double height, double width) {
    return Column(
      children: <Widget>[
        Container(
          height: height * 0.402,
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                height: height * 0.34,
                width: double.infinity,
                child: Image.asset(
                  "assets/images/prius_profile.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: height * 0.34,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.black.withOpacity(0),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: height * 0.062,
                  ),
                  child: Container(
                    height: height * 0.06,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Center(
                              child: Text(
                                "",
                                style: TextStyle(
                                  fontSize: height * 0.024,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(left: height * 0.05),
                                child: Text(
                                  "УБА 2424",
                                  style: TextStyle(
                                    fontSize: height * 0.024,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2.0,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(
                      height * 0.2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      height * 0.2,
                    ),
                    child: Image.asset(
                      "assets/images/me.jpg",
                      fit: BoxFit.cover,
                      height: height * 0.14,
                      width: height * 0.14,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: height * 0.03,
                    left: width * 0.05,
                  ),
                  child: Text(
                    "TOYOTA",
                    style: TextStyle(
                      fontSize: height * 0.018,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: height * 0.056,
                    left: width * 0.05,
                  ),
                  child: Text(
                    "PRIUS 30",
                    style: TextStyle(
                      fontSize: height * 0.023,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: height * 0.03,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ALTANKHUYAG ",
                    style: TextStyle(
                      color: kTextGrey,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    " BAYARBILEG",
                    style: TextStyle(
                      color: kTextDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.004,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.phone,
                    size: height * 0.016,
                    color: kTextGrey,
                  ),
                  SizedBox(width: width * 0.02),
                  Text(
                    "9911-5053",
                    style: TextStyle(
                      color: kTextGrey,
                      fontSize: height * 0.016,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: height * 0.032,
            right: width * 0.04,
            left: width * 0.04,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "  Аралын дугаар",
                    style: TextStyle(
                      color: kTextGrey,
                      fontSize: height * 0.018,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "YKP39  ",
                    style: TextStyle(
                      color: kTextDark,
                      fontSize: height * 0.022,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "  Үйлдвэрлэсэн он",
                    style: TextStyle(
                      color: kTextGrey,
                      fontSize: height * 0.018,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "2011  ",
                    style: TextStyle(
                      color: kTextDark,
                      fontSize: height * 0.022,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "  Орж ирсэн он",
                    style: TextStyle(
                      color: kTextGrey,
                      fontSize: height * 0.018,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "2015  ",
                    style: TextStyle(
                      color: kTextDark,
                      fontSize: height * 0.022,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "  Өнгө",
                    style: TextStyle(
                      color: kTextGrey,
                      fontSize: height * 0.018,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 12.0,
                        width: 12.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            50.0,
                          ),
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "  Цагаан  ",
                        style: TextStyle(
                          color: kTextDark,
                          fontSize: height * 0.022,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: height * 0.032,
            right: width * 0.04,
            left: width * 0.04,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    height * 0.01,
                  ),
                  child: Material(
                    color: Colors.white.withOpacity(0.9),
                    child: InkWell(
                      splashColor: kTextGrey,
                      onTap: () {
                        Navigator.pushNamed(context, "/edit_part");
                      },
                      child: Container(
                        height: height * 0.07,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.4,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(
                            height * 0.01,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: height * 0.01,
                            right: height * 0.01,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: height * 0.008,
                                    ),
                                    child: Image.asset(
                                      "assets/images/engine_oil.png",
                                      color: kTextGrey,
                                    ),
                                  ),
                                  SizedBox(
                                    width: height * 0.01,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Авто тосол",
                                        style: TextStyle(
                                          fontSize: height * 0.018,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Feb 6, 2021      ",
                                          style: TextStyle(
                                            fontSize: height * 0.014,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: kGreyColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: height * 0.022,
            right: width * 0.04,
            left: width * 0.04,
            bottom: height * 0.022,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    height * 0.01,
                  ),
                  child: Material(
                    color: Colors.white.withOpacity(
                      0.9,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/add_part");
                      },
                      splashColor: kTextGrey,
                      child: Container(
                        height: height * 0.07,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.4,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(
                            height * 0.01,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: height * 0.022,
                            right: height * 0.01,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Эд анги нэмэх",
                                style: TextStyle(
                                  fontSize: height * 0.018,
                                ),
                              ),
                              Icon(
                                Icons.add,
                                color: kGreyColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
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
                          // Navigator.of(context).pop(context);
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "/home", (Route<dynamic> route) => false);
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
                      "Profile",
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
                          color: kColor3,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, "/profile_car_edit");
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
                                  Icons.car_repair,
                                  color: Colors.white,
                                  size: height * 0.022,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
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
                              Navigator.pushNamed(context, "/profile_edit");
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
                                  Icons.account_box,
                                  color: Colors.white,
                                  size: height * 0.022,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
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
                          color: kColor2,
                          child: InkWell(
                            onTap: () {
                              UserPreferences().removeUser();
                              Navigator.pushNamed(context, "/home");
                              print("logout");
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
                                  Icons.exit_to_app,
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
