import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
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
  PageController _pageController;

  String _sliders;

  @override
  void initState() {
    super.initState();

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
          if (["", " ", null, false, 0].contains(_sliders)) _profileCarInfo(),
          if (!["", " ", null, false, 0].contains(_sliders)) _banner(),
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
          itemCount: CarData.items.length,
          itemBuilder: (BuildContext context, int index) => Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: widget.height * 0.028,
                  ),
                  child: Text(
                    CarData.items[index]["mark"],
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
                    CarData.items[index]["name"],
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
                    height: widget.height * 0.3,
                    child: Stack(
                      children: [
                        Center(
                          child: Image.asset(CarData.items[index]["image"]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: widget.height * 0.02),
                  child: Container(
                    height: widget.height * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(height: widget.height * 0.03),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/batery.png",
                              height: widget.height * 0.026,
                            ),
                            SizedBox(
                              height: widget.height * 0.003,
                            ),
                            Text(
                              "Battery",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: widget.height * 0.012,
                              ),
                            ),
                            SizedBox(
                              height: widget.height * 0.003,
                            ),
                            Text(
                              CarData.items[index]["battery"],
                              style: TextStyle(
                                color: kLightRed,
                                fontWeight: FontWeight.w500,
                                fontSize: widget.height * 0.013,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/araa.png",
                              height: widget.height * 0.026,
                            ),
                            SizedBox(
                              height: widget.height * 0.003,
                            ),
                            Text(
                              "Хурдны хайрцаг",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: widget.height * 0.012,
                              ),
                            ),
                            SizedBox(
                              height: widget.height * 0.003,
                            ),
                            Text(
                              CarData.items[index]["araa"],
                              style: TextStyle(
                                color: kLightRed,
                                fontWeight: FontWeight.w500,
                                fontSize: widget.height * 0.013,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/motor.png",
                              height: widget.height * 0.026,
                            ),
                            SizedBox(
                              height: widget.height * 0.003,
                            ),
                            Text(
                              "Моторын багтаамж",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: widget.height * 0.012,
                              ),
                            ),
                            SizedBox(
                              height: widget.height * 0.003,
                            ),
                            Text(
                              CarData.items[index]["motorcc"],
                              style: TextStyle(
                                color: kLightRed,
                                fontWeight: FontWeight.w500,
                                fontSize: widget.height * 0.013,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/car.png",
                              height: widget.height * 0.026,
                            ),
                            SizedBox(
                              height: widget.height * 0.003,
                            ),
                            Text(
                              "Төрөл",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: widget.height * 0.012,
                              ),
                            ),
                            SizedBox(
                              height: widget.height * 0.003,
                            ),
                            Text(
                              CarData.items[index]["carType"],
                              style: TextStyle(
                                color: kLightRed,
                                fontWeight: FontWeight.w500,
                                fontSize: widget.height * 0.013,
                              ),
                            ),
                          ],
                        ),
                        Container(height: widget.height * 0.03),
                      ],
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
