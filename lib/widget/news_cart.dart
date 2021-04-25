import 'package:carpro/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';

class NewsCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.03,
                      right: MediaQuery.of(context).size.height * 0.03,
                      bottom: MediaQuery.of(context).size.height * 0.02),
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      depth: 3,
                      intensity: 0.7,
                      shadowLightColor: Colors.white,
                      shadowDarkColor: Colors.black87,
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(5.0),
                      ),
                      lightSource: LightSource.topLeft,
                      shape: NeumorphicShape.convex,
                      surfaceIntensity: 1,
                    ),
                    child: Card(
                      color: Colors.transparent,
                      elevation: 0.0,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.height * 0.01),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/clock.png",
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.012,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          DateFormat('m').format(now) + "мин",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: -1,
                                  child: InkWell(
                                    child: Icon(
                                      Icons.more_horiz,
                                      size: MediaQuery.of(context).size.height *
                                          0.03,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.22,
                              left: MediaQuery.of(context).size.height * 0.01,
                              right: MediaQuery.of(context).size.height * 0.01,
                              bottom: MediaQuery.of(context).size.height * 0.02,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Авто лизингийн хүү  0,1% боллоо",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.016,
                                    fontWeight: FontWeight.bold,
                                    color: kTextColor,
                                  ),
                                ),
                                InkWell(
                                  child: Image.asset(
                                    "assets/bookmark.png",
                                    height: MediaQuery.of(context).size.height *
                                        0.015,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Html(
                              data:
                                  "Lorem ipsum Suspendisse eget lectus eu metus eleifend sagittis. Suspendisse eleifend vulputate sodales. Integer sit amet metus quis enim ornare tempus. Sed molestie quam et erat volutpat congue. Etiam a massa at odio vulputate interdum. Phasellus quis arcu sit amet mauris facilisis euismod in mollis sapien. Ut laoreet, nulla vitae iaculis rutrum, diam mauris malesuada orci, a scelerisque orci arcu non turpis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Fusce hendrerit lorem finibus ex auctor fermentum sed in eros. Praesent in rhoncus lectus. Etiam molestie ante quis eros accumsan porttitor. Cras at metus congue, sodales est eget, ultricies mauris. Etiam sit amet nunc ut ipsum rutrum molestie sed in ante. Nam et metus id mi dignissim tincidunt. Nullam in augue gravida, interdum quam a, bibendum est. Nunc ornare tellus sit amet facilisis ultrices. Interdum et malesuada fames ac ante ipsum primis in faucibus. Vivamus in pharetra risus. Praesent hendrerit, nisi et tempor ornare, ex metus lobortis tortor, nec eleifend nunc magna quis odio. Sed quis nisl cursus, sodales dui sit amet, dignissim augue. Morbi fringilla condimentum eros quis pretium. In dignissim, erat et auctor tempor, est tortor elementum arcu, id cursus justo erat id massa. Donec at faucibus urna. Ut consectetur neque risus, ac lobortis turpis maximus nec. Suspendisse maximus mauris felis. Nunc dictum sem quis nulla lacinia bibendum. Fusce sit amet lectus id libero ultrices dictum lacinia id neque.",
                              style: {
                                "body": Style(
                                  fontFamily: "Montserrat",
                                  fontSize: FontSize(11),
                                  alignment: Alignment.topLeft,
                                  wordSpacing: 1.5,
                                ),
                                "ul": Style(
                                  margin: EdgeInsets.all(0),
                                  padding: EdgeInsets.all(0),
                                ),
                                "li": Style(
                                  margin: EdgeInsets.all(0),
                                  padding: EdgeInsets.all(0),
                                )
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height,
                      maxWidth: MediaQuery.of(context).size.width,
                    ),
                    child: Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.04,
                        right: MediaQuery.of(context).size.height * 0.04,
                        left: MediaQuery.of(context).size.height * 0.04,
                      ),
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width,
                      // decoration: BoxDecoration(
                      //   color: Colors.white,
                      //   borderRadius: BorderRadius.circular(10),
                      // ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image(
                          image: AssetImage(
                            "assets/car_bg.jpeg",
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
