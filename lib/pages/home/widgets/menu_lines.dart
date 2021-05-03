import 'package:flutter/material.dart';

class MenuLines extends StatelessWidget {
  final double height;
  final double width;

  const MenuLines({
    Key key,
    this.height,
    this.width,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                top: height * 0.06,
                right: height * 0.20,
              ),
              child: RotationTransition(
                turns: new AlwaysStoppedAnimation(-38.0 / 360.0),
                child: Image.asset(
                  "assets/images/line.png",
                  width: height * 0.054,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                top: height * 0.06,
                left: height * 0.20,
              ),
              child: RotationTransition(
                turns: new AlwaysStoppedAnimation(38.0 / 360.0),
                child: Image.asset(
                  "assets/images/line.png",
                  width: height * 0.054,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                top: height * 0.25,
                left: height * 0.34,
              ),
              child: RotationTransition(
                turns: new AlwaysStoppedAnimation(68.0 / -360.0),
                child: Image.asset(
                  "assets/images/line.png",
                  width: height * 0.054,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                top: height * 0.25,
                right: height * 0.34,
              ),
              child: RotationTransition(
                turns: new AlwaysStoppedAnimation(-68.0 / -360.0),
                child: Image.asset(
                  "assets/images/line.png",
                  width: height * 0.054,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                top: height * 0.37,
              ),
              child: RotationTransition(
                turns: new AlwaysStoppedAnimation(0.0 / 360.0),
                child: Image.asset(
                  "assets/images/line.png",
                  width: height * 0.054,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
