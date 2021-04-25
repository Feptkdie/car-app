import 'package:carpro/model/sos_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SosCard extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(ctx).size.height * 0.08,
      ),
      child: GridView.builder(
        itemCount: cardItem.length + 1,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: MediaQuery.of(ctx).size.width /
              (MediaQuery.of(ctx).size.height / 1.95),
          crossAxisCount: 2,
          crossAxisSpacing: MediaQuery.of(ctx).size.height * 0.01,
          mainAxisSpacing: MediaQuery.of(ctx).size.height * 0.01,
        ),
        itemBuilder: (BuildContext ctx, int index) {
          return Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(ctx).size.height * 0.02,
              right: MediaQuery.of(ctx).size.height * 0.03,
              left: MediaQuery.of(ctx).size.height * 0.03,
              bottom: MediaQuery.of(ctx).size.height * .01,
            ),
            child: Stack(
              children: [
                Neumorphic(
                  style: NeumorphicStyle(
                      color: Colors.white,
                      depth: 2,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(9)),
                      shadowDarkColor: Color(0XFF7E8081),
                      shadowLightColor: Colors.white,
                      lightSource: LightSource.topLeft,
                      intensity: 0.9,
                      shape: NeumorphicShape.convex,
                      surfaceIntensity: 1.5),
                  child: Container(),
                ),
                cardItem.length > index
                    ? Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image(
                              image: AssetImage(cardItem[index].image),
                              height: MediaQuery.of(ctx).size.height * 0.08,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(ctx).size.height * 0.02,
                                left: MediaQuery.of(ctx).size.height * 0.01,
                                right: MediaQuery.of(ctx).size.height * 0.01,
                              ),
                              child: Text(
                                cardItem[index].title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF556062),
                                  fontFamily: "Montserrat",
                                  fontSize:
                                      MediaQuery.of(ctx).size.height * 0.018,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: Image(
                          image: AssetImage("assets/add_button.png"),
                          height: MediaQuery.of(ctx).size.height * 0.055,
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
