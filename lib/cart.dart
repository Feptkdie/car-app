import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.03,
                right: MediaQuery.of(context).size.height * 0.03,
                bottom: MediaQuery.of(context).size.height * 0.02),
            child: Neumorphic(
              style: NeumorphicStyle(
                depth: 4,
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
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height,
                    // maxWidth: MediaQuery.of(context).size.height * 0.3,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Row(
                          children: [
                            Icon(
                              Icons.timelapse,
                              size: MediaQuery.of(context).size.height * 0.02,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                DateFormat('m').format(now) + "мин",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.016),
                              ),
                            ),
                          ],
                        ),
                        trailing: InkWell(
                          child: Icon(
                            Icons.more_horiz,
                            size: MediaQuery.of(context).size.height * 0.03,
                          ),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.13,
                          left: MediaQuery.of(context).size.height * 0.025,
                          right: MediaQuery.of(context).size.height * 0.025,
                        ),
                        title: Text(
                          "Авто лизингийн хүү  0,1% боллоо",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        trailing: InkWell(
                          child: Icon(
                            Icons.bookmark_border,
                            size: MediaQuery.of(context).size.height * 0.03,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.height * 0.02),
                            child: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec id vulputate massa, id convallis nibh. Suspendisse eget lectus eu metus eleifend sagittis. Suspendisse eleifend vulputate sodales. Integer sit amet metus quis enim ornare tempus. Sed molestie quam et erat volutpat congue. Etiam a massa at odio vulputate interdum. Phasellus quis arcu sit amet mauris facilisis euismod in mollis sapien. Ut laoreet, nulla vitae iaculis rutrum, diam mauris malesuada orci, a scelerisque orci arcu non turpis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Fusce hendrerit lorem finibus ex auctor fermentum sed in eros. Praesent in rhoncus lectus. Etiam molestie ante quis eros accumsan porttitor. Cras at metus congue, sodales est eget, ultricies mauris. Etiam sit amet nunc ut ipsum rutrum molestie sed in ante. Nam et metus id mi dignissim tincidunt. Nullam in augue gravida, interdum quam a, bibendum est. Nunc ornare tellus sit amet facilisis ultrices. Interdum et malesuada fames ac ante ipsum primis in faucibus. Vivamus in pharetra risus. Praesent hendrerit, nisi et tempor ornare, ex metus lobortis tortor, nec eleifend nunc magna quis odio. Sed quis nisl cursus, sodales dui sit amet, dignissim augue. Morbi fringilla condimentum eros quis pretium. In dignissim, erat et auctor tempor, est tortor elementum arcu, id cursus justo erat id massa. Donec at faucibus urna. Ut consectetur neque risus, ac lobortis turpis maximus nec. Suspendisse maximus mauris felis. Nunc dictum sem quis nulla lacinia bibendum. Fusce sit amet lectus id libero ultrices dictum lacinia id neque.",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.018,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.015,
              right: MediaQuery.of(context).size.height * 0.06,
              left: MediaQuery.of(context).size.height * 0.06,
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05),
                  height: MediaQuery.of(context).size.height * 0.17,
                  width: MediaQuery.of(context).size.width / 1,
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
          ),
        ],
      ),
    );
  }
}
