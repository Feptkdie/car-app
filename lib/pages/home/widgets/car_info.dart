import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        children: [
          Align(
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
                                child:
                                    Image.asset(CarData.items[index]["image"]),
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
          ),
          Align(
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
          ),
        ],
      ),
    );
  }
}
