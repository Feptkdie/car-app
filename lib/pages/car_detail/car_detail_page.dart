// import 'package:carpro/news_screen.dart';
import 'package:carpro_app/providers/car_provider.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import './widgets/map.dart';
import './widgets/arrow_button.dart';
import './widgets/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CarDetailPage extends StatefulWidget {
  static String routeName = "/car-detail";

  final DateTime dateTime = DateTime.now();

  @override
  _CarDetailPageState createState() => _CarDetailPageState();
}

class _CarDetailPageState extends State<CarDetailPage> {
  String moneyFormat(String price) {
    if (price.length > 2) {
      var value = price;
      value = value.replaceAll(RegExp(r'\D'), '');
      value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
      return value;
    } else {
      return "0";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackColor1,
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
              // Profile(),
            ],
          ),
        ),
      ),
      body: Consumer<CarProvider>(
        builder: (context, carProvider, child) {
          if (carProvider.getCar != null) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: ListTile(
                      title: Text(
                        carProvider.getCar.name,
                        style: TextStyle(
                          color: kTextColor,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      subtitle: Text(
                        "₮${moneyFormat(carProvider.getCar.price.toString())}",
                        style: TextStyle(
                          color: kColor3,
                          fontFamily: "MontserratSemiBold",
                          fontWeight: FontWeight.normal,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 250.0,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          children: [
                            Container(
                              // color: Colors.black,
                              height: 250.0,
                              width: double.infinity,
                              child: Image.network(
                                carProvider.getCar.images[index]["url"],
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
                      scale: 0.95,
                      layout: SwiperLayout.DEFAULT,
                      autoplay: false,
                      itemCount: carProvider.getCar.images.length,
                      pagination: SwiperPagination(
                        margin: EdgeInsets.only(bottom: 10.0),
                        builder: DotSwiperPaginationBuilder(
                          color: kGreyColor,
                          activeColor: kRedColor,
                          size: 10.0,
                          activeSize: 10.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // gradient: LinearGradient(
                      //   begin: Alignment.topCenter,
                      //   end: Alignment.bottomCenter,
                      //   colors: [
                      //     kBackColor1,
                      //     Colors.white,
                      //   ],
                      // ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              "assets/images/man_drive.png",
                              height: 28.0,
                            ),
                            Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Text(
                                "Жолооны хүрд",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 11.0,
                                  color: kTextColor,
                                ),
                              ),
                            ),
                            Text(
                              "${carProvider.getCar.drivderHand == 'left' ? 'Зөв' : 'Буруу'}",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 12.0,
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
                              "assets/images/box.png",
                              height: 28.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                "Хроп",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 11.0,
                                  color: kTextColor,
                                ),
                              ),
                            ),
                            Text(
                              "${carProvider.getCar.hrop == 'automat' ? 'Автомат' : 'Механик'}",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 12.0,
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
                              "assets/images/motor.png",
                              height: 28.0,
                            ),
                            Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Text(
                                "Хөд багтаамж",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 11.0,
                                  color: kTextColor,
                                ),
                              ),
                            ),
                            Text(
                              "${carProvider.getCar.engineCapacity}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 12.0,
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
                              "assets/images/turul.png",
                              height: 28.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                "Төрөл",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 11.0,
                                  color: kTextColor,
                                ),
                              ),
                            ),
                            Text(
                              "${carProvider.getCar.group['name']}",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: kLightRed,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Нэмэлт мэдээлэл",
                    ),
                  ),
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Container(
                        height: 36,
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Text("Үйлдвэрлэсэн он"),
                            Spacer(),
                            Text(carProvider.getCar.madeInYear.toString()),
                          ],
                        ),
                      ),
                      Container(
                        height: 36,
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Text("Орж ирсэн он"),
                            Spacer(),
                            Text(carProvider.getCar.importYear.toString()),
                          ],
                        ),
                      ),
                      Container(
                        height: 36,
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Text("Орж ирсэн сар"),
                            Spacer(),
                            Text(carProvider.getCar.importMonth.toString()),
                          ],
                        ),
                      ),
                      Container(
                        height: 36,
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Text("Гүйлт"),
                            Spacer(),
                            Text(
                                "${carProvider.getCar.runningKm.toString()} км"),
                          ],
                        ),
                      ),
                      Container(
                        height: 36,
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Text("Хөтлөгч"),
                            Spacer(),
                            if (carProvider.getCar.hutlugch == "urdaa")
                              Text("Урдаа"),
                            if (carProvider.getCar.hutlugch == "hoinoo")
                              Text("Хойноо"),
                            if (carProvider.getCar.hutlugch == "buh_duguin")
                              Text("Бүх дугуйн"),
                          ],
                        ),
                      ),
                      Container(
                        height: 36,
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Text("Моторын төрөл"),
                            Spacer(),
                            if (carProvider.getCar.fuel == "benzine")
                              Text("Бензин"),
                            if (carProvider.getCar.fuel == "diesel")
                              Text("Дизель"),
                            if (carProvider.getCar.fuel == "gas") Text("Газ"),
                            if (carProvider.getCar.fuel == "hybrid")
                              Text("Хайбрид"),
                            if (carProvider.getCar.fuel == "electric")
                              Text("Цахилгаан"),
                          ],
                        ),
                      ),
                      Container(
                        height: 36,
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Text("Борлуулагч"),
                            Spacer(),
                            Text("${carProvider.getCar.seller.toString()}"),
                          ],
                        ),
                      ),
                      Container(
                        height: 36,
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Text("Утас"),
                            Spacer(),
                            Text("${carProvider.getCar.phone.toString()}"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Дэлгэрэнгүй тайлбар",
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    color: Colors.white,
                    child: Text(carProvider.getCar.description),
                  ),
                ],
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
