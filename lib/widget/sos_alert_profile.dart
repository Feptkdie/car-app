import 'package:flutter/material.dart';

class SosAlertPro extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(ctx).size.height * 0.035),
      child: CircleAvatar(
        radius: 40.0,
        backgroundImage: AssetImage("assets/profile_icon.png"),
        backgroundColor: Colors.white,
      ),
    );
  }
}
