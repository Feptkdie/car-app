import 'package:carpro_app/models/sos_category.dart';
import 'package:carpro_app/providers/sos_category_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
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

    return Scaffold(
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
    );
  }
}
