import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return Padding(
      padding: EdgeInsets.only(right: MediaQuery.of(ctx).size.height * 0.02),
      child: Neumorphic(
        style: NeumorphicStyle(
          border: NeumorphicBorder(
            width: 1.5,
          ),
          depth: 3,
          disableDepth: false,
          shadowLightColor: Colors.white,
          shadowDarkColor: Color(0xff7E8081),
          boxShape: NeumorphicBoxShape.circle(),
          intensity: 1,
          lightSource: LightSource.topLeft,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(ctx).size.height * 0.06,
          ),
          child: Image(
            image: AssetImage(
              "assets/profile.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
