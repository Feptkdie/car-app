import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class ArrowButton extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return Theme.of(ctx).platform == TargetPlatform.iOS
        ? Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(ctx).size.height * 0.015),
            child: CupertinoButton(
              onPressed: () {},
              child: Container(
                height: MediaQuery.of(ctx).size.height * 0.045,
                width: MediaQuery.of(ctx).size.height * 0.045,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    kLightRed,
                    kRedColor,
                  ]),
                ),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: MediaQuery.of(ctx).size.height * 0.03,
                ),
              ),
            ),
          )
        : Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(ctx).size.height * 0.015),
            child: InkWell(
              onTap: () {
                Navigator.of(ctx).pop();
                print("clicked");
              },
              child: Container(
                height: MediaQuery.of(ctx).size.height * 0.045,
                width: MediaQuery.of(ctx).size.height * 0.045,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    kLightRed,
                    kRedColor,
                  ]),
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: MediaQuery.of(ctx).size.height * 0.03,
                ),
              ),
            ),
          );
  }
}
