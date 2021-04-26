import 'package:carpro/news_screen.dart';
import 'package:carpro/widget/arrow_button.dart';
import 'package:carpro/widget/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'constants.dart';

class SaleDetailScreen extends StatefulWidget {
  DateTime dateTime = DateTime.now();
  // var _details = [
  //   {
  //     "icon": "assets/battery.png",
  //     "title": "baterry",
  //     "uzuulelt": "99%",
  //   },
  //   {
  //     "icon": "assets/box.png",
  //     "title": "Хурдны хайрцаг",
  //     "uzuulelt": "IAT",
  //   },
  //   {
  //     "icon": "assets/motor.png",
  //     "title": "моторын багтаамж",
  //     "uzuulelt": "2400 cc",
  //   },
  //   {
  //     "icon": "assets/turul.png",
  //     "title": "Төрөл",
  //     "uzuulelt": "HS250H VER-I",
  //   },
  // ];
  @override
  _SaleDetailScreenState createState() => _SaleDetailScreenState();
}

class _SaleDetailScreenState extends State<SaleDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.1,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.05,
            // bottom: MediaQuery.of(context).size.height * 0.02,
          ),
          child: Row(
            children: [
              ArrowButton(),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.025),
                child: Neumorphic(
                  style: NeumorphicStyle(
                    depth: 3,
                    boxShape: NeumorphicBoxShape.circle(),
                    disableDepth: false,
                    shadowLightColor: Colors.white,
                    shadowDarkColor: kGreyColor,
                    intensity: 1,
                    lightSource: LightSource.topLeft,
                  ),
                  child: InkWell(
                    onTap: () {
                      print("clicked");
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.045,
                      width: MediaQuery.of(context).size.height * 0.045,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // gradient: LinearGradient(colors: [
                        //   kLightRed,
                        //   kRedColor,
                        // ]),
                        color: Colors.grey,
                      ),
                      child: Icon(
                        Icons.star_rounded,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.height * 0.03,
                      ),
                    ),
                  ),
                ),
              ),
              Profile(),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      kPrimaryColor,
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: ListTile(
                      title: Text(
                        "Sonata 2018",
                        style: TextStyle(
                            color: kTextColor,
                            fontFamily: "Lato",
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.025),
                      ),
                      subtitle: Text(
                        "₮55'000'000",
                        style: TextStyle(
                            color: kTextColor,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.normal,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.015),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          children: [
                            Container(
                              // color: Colors.black,
                              height: MediaQuery.of(context).size.height * 0.32,
                              width: double.infinity,
                              child: Image.asset(
                                "assets/sonata.png",
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        );
                      },
                      // viewportFraction: 1,
                      // scale: 0.9,
                      layout: SwiperLayout.DEFAULT,
                      autoplay: false,
                      itemCount: 4,
                      pagination: SwiperPagination(
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.015),
                        builder: DotSwiperPaginationBuilder(
                          color: kGreyColor,
                          activeColor: kRedColor,
                          size: MediaQuery.of(context).size.height * 0.014,
                          activeSize:
                              MediaQuery.of(context).size.height * 0.014,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.44,
                        bottom: MediaQuery.of(context).size.height * 0.028),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              "assets/battery.png",
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Text(
                                "Battery",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.015,
                                  color: kTextColor,
                                ),
                              ),
                            ),
                            Text(
                              "99%",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.016,
                                fontWeight: FontWeight.bold,
                                color: kLightRed,
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              "assets/box.png",
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                "Хурдны хайрцаг",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.015,
                                  color: kTextColor,
                                ),
                              ),
                            ),
                            Text(
                              "IAT",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.016,
                                fontWeight: FontWeight.bold,
                                color: kLightRed,
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              "assets/motor.png",
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Text(
                                "Моторын багтаамж",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.015,
                                  color: kTextColor,
                                ),
                              ),
                            ),
                            Text(
                              "2400 cc",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.016,
                                fontWeight: FontWeight.bold,
                                color: kLightRed,
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              "assets/turul.png",
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                "Төрөл",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.015,
                                  color: kTextColor,
                                ),
                              ),
                            ),
                            Text(
                              "HS250H VER-I",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.016,
                                fontWeight: FontWeight.bold,
                                color: kLightRed,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.025,
                vertical: MediaQuery.of(context).size.height * 0.02,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Авто машины байршил",
                          style: TextStyle(
                            color: kTextColor,
                            fontFamily: "Lato",
                            fontSize:
                                MediaQuery.of(context).size.height * 0.019,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage("assets/pin.png"),
                                height:
                                    MediaQuery.of(context).size.height * 0.023,
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.height *
                                      0.01),
                              Text(
                                "Токио хот",
                                style: TextStyle(
                                  fontFamily: "Lato",
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.015,
                                  color: kTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Тээвэрлэгдэх огноо",
                          style: TextStyle(
                            color: kTextColor,
                            fontFamily: "Lato",
                            fontSize:
                                MediaQuery.of(context).size.height * 0.019,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                          child: Expanded(
                            child: Row(
                              children: [
                                Image(
                                  image: AssetImage("assets/calendar.png"),
                                  height: MediaQuery.of(context).size.height *
                                      0.023,
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.height *
                                        0.01),
                                Text(
                                  "4-р сарын 30",
                                  style: TextStyle(
                                    fontFamily: "Lato",
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.015,
                                    color: kTextColor,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.015),
                                  child: Image(
                                    image: AssetImage("assets/timer.png"),
                                    height: MediaQuery.of(context).size.height *
                                        0.023,
                                  ),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.height *
                                        0.01),
                                Text(
                                  "16:00 цаг",
                                  style: TextStyle(
                                    fontFamily: "Lato",
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.015,
                                    color: kTextColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.13,
                      // width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Text("hi"),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
