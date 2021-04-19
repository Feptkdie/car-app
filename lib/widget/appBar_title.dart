import 'package:flutter/material.dart';

import '../constants.dart';

class AppBarTitle extends StatelessWidget {
  final String title;
  AppBarTitle({this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.015),
      child: Text(
        title,
        style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: MediaQuery.of(context).size.height * 0.026,
            fontWeight: FontWeight.bold,
            color: kTextColor),
      ),
    );
  }
}
