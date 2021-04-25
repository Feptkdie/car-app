// import 'package:carpro/constants.dart';
import 'package:carpro/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return Container(
      height: MediaQuery.of(ctx).size.height * 0.065,
      width: MediaQuery.of(ctx).size.height * 0.065,
      margin: EdgeInsets.only(right: MediaQuery.of(ctx).size.height * 0.02),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage("assets/profile.jpg"),
            fit: BoxFit.fill,
          ),
          // shape: BoxShape.circle,
          border: Border.all(
            width: 1,
            color: kGreyColor,
          ),
          boxShadow: [
            BoxShadow(
                color: Color(0xff090010).withOpacity(0.7),
                offset: Offset(10, 10),
                blurRadius: 25.0,
                spreadRadius: 1.0),
            BoxShadow(
                color: Color(0xFF7E8081).withOpacity(0.5),
                offset: Offset(-10, -10),
                blurRadius: 20.0,
                spreadRadius: 1.0),
          ]),
    );
  }
}
