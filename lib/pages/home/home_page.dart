import 'package:flutter/material.dart';

import '../../constants.dart';
import 'widgets/car_info.dart';
import 'widgets/menu_buttons.dart';
import 'widgets/menu_lines.dart';
import 'widgets/power_button.dart';

class HomePage extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () {},
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
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
            child: Stack(
              children: [
                PowerButton(
                  height: height,
                  width: width,
                ),
                MenuLines(
                  height: height,
                  width: width,
                ),
                MenuButtons(
                  height: height,
                  width: width,
                ),
                CarInfo(
                  height: height,
                  width: width,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
