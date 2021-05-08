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
  initState() {
    _showAlert();
    super.initState();
  }

  _showAlert() async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        contentPadding: EdgeInsets.zero,
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              8.0,
            ),
            gradient: new LinearGradient(
              colors: [
                kBackColor1,
                Colors.grey,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 16.0,
              ),
              Text(
                "Тавтай морил",
                style: TextStyle(
                  color: kTextGrey,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                "Release coming soon",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  18.0,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: new LinearGradient(
                          colors: [
                            Color(0xffed1c24),
                            Color(0xff811c24),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      width: 90.0,
                      height: 28.0,
                      child: Center(
                        child: Text(
                          "ХААХ",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

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
