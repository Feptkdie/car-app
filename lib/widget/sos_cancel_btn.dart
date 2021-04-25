import 'package:flutter/material.dart';

import '../constants.dart';

class SosCancelBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.015,
        left: MediaQuery.of(context).size.height * 0.4,
        right: MediaQuery.of(context).size.height * 0.01,
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          width: MediaQuery.of(context).size.height * 0.045,
          height: MediaQuery.of(context).size.height * 0.045,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.8),
                offset: Offset(-6.0, -6.0),
                blurRadius: 10.0,
              ),
              BoxShadow(
                color: kGreyColor,
                offset: Offset(6.0, 6.0),
                blurRadius: 15.0,
              ),
            ],
            // color: Color(0xFFEFEEEE),
            gradient: LinearGradient(
              colors: [kLightRed, kRedColor],
            ),
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: EdgeInsets.all(6.0),
            child: Image.asset(
              "assets/x-icon.png",
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
