import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:carpro_app/helpers/user_preferences.dart';
import 'package:carpro_app/models/user.dart';
import 'package:carpro_app/providers/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

class CarData {
  static List items = [
    {
      "image": "assets/images/prius.png",
      "name": "PRIUS 30",
      "mark": "TOYOTA",
      "battery": "94%",
      "araa": "IAT",
      "motorcc": "2400 cc",
      "carType": "HS520",
    },
    {
      "image": "assets/images/benz.png",
      "name": "BENZ",
      "mark": "BENZ",
      "battery": "байхгүй",
      "araa": "IAT",
      "motorcc": "3200",
      "carType": "BZG12",
    },
  ];
}

class CarInfo extends StatefulWidget {
  final double height;
  final double width;

  const CarInfo({
    Key key,
    this.height,
    this.width,
  }) : super(key: key);
  @override
  _CarInfoState createState() => _CarInfoState();
}

class _CarInfoState extends State<CarInfo> {
  Future<User> _userPrefs;
  bool isLogged = false;
  User _currentUser;
  dynamic _currentCar;
  var cars;
  PageController _pageController;

  String _sliders;

  @override
  void initState() {
    super.initState();

    _userPrefs = UserPreferences().getUser();

    _userPrefs.then((User user) {
      if (user.token == null) {
        isLogged = false;
      } else {
        setState(() {
          _currentUser = user;

          if (_currentUser.cars != null) {
            cars = json.decode(_currentUser.cars);
            if (cars.length > 0) _currentCar = cars[0];
          }

          print(_currentCar);

          isLogged = true;
        });
      }
    }).catchError((err) {
      print(err);
      isLogged = false;
      Navigator.pushReplacementNamed(context, "/login");
    });

    var settings = context.read<SettingProvider>().getSettings;

    if (settings.length > 0) {
      if (!["", " ", null, false, 0].contains(settings[0].sliders)) {
        _sliders = settings[0].sliders;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        children: [
          if (!["", " ", null, false, 0].contains(_currentCar))
            _profileCarInfo(),
          // if (["", " ", null, false, 0].contains(_currentCar)) _banner(),
          // _sliderArrows(),
        ],
      ),
    );
  }

  Widget _banner() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        // height: double.infinity,
        height: MediaQuery.of(context).size.height * 0.40,
        width: double.infinity,
        // color: Colors.red,
        padding: EdgeInsets.all(20.0),
        child: Swiper(
          scale: 0.9,
          itemBuilder: (BuildContext context, int index) {
            return Image.network(
              json.decode(_sliders)[index]["url"],
              fit: BoxFit.cover,
            );
          },
          itemCount: json.decode(_sliders).length,
          pagination: new SwiperPagination(),
          // control: new SwiperControl(),
        ),
      ),
    );
  }

  Widget _profileCarInfo() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: widget.height * 0.46,
        child: PageView.builder(
          controller: _pageController,
          itemCount: cars.length,
          itemBuilder: (BuildContext context, int index) => Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: widget.height * 0.028,
                  ),
                  child: Text(
                    cars[index]["mark_name"],
                    style: TextStyle(
                      fontSize: widget.height * 0.01,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: widget.height * 0.036,
                  ),
                  child: Text(
                    cars[index]["name"],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kTextDark,
                      fontSize: widget.height * 0.024,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(bottom: widget.height * 0.04),
                  child: Container(
                    height: widget.height * 0.26,
                    child: Stack(
                      children: [
                        Center(
                          child: Image.network(cars[index]["cover"]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (cars[index]["parts"].isNotEmpty)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: widget.height * 0.02),
                    child: Container(
                      height: widget.height * 0.1,
                      width: widget.width,
                      child: AnimatedList(
                        scrollDirection: Axis.horizontal,
                        initialItemCount: cars[index]["parts"].length,
                        itemBuilder: (BuildContext context, int index2,
                                Animation<double> animation) =>
                            Padding(
                          padding: EdgeInsets.only(
                            left: widget.width * 0.04,
                            right: widget.width * 0.04,
                          ),
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(-1, 0),
                              end: Offset(0, 0),
                            ).animate(CurvedAnimation(
                                parent: animation,
                                curve: Curves.bounceIn,
                                reverseCurve: Curves.bounceOut)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  cars[index]["parts"][index2]["name"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: widget.height * 0.012,
                                  ),
                                ),
                                SizedBox(
                                  height: widget.height * 0.003,
                                ),
                                Text(
                                  cars[index]["parts"][index2]["created_at"]
                                      .toString()
                                      .substring(0, 10),
                                  style: TextStyle(
                                    color: kLightRed,
                                    fontWeight: FontWeight.w500,
                                    fontSize: widget.height * 0.013,
                                  ),
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
      ),
    );
  }

  Widget _sliderArrows() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: widget.height * 0.46,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: widget.height * 0.02,
                ),
                child: Image.asset(
                  "assets/images/left.png",
                  height: widget.height * 0.02,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(
                  right: widget.height * 0.02,
                ),
                child: Image.asset(
                  "assets/images/right.png",
                  height: widget.height * 0.02,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
