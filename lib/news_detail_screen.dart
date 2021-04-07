import 'package:carpro/news_appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';

class NewsDetailScreen extends StatefulWidget {
  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffd0d3d5),
        elevation: 0.0,
        leading: Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pop(context);
              },
              child: Theme.of(context).platform == TargetPlatform.iOS
                  ? Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.02),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [
                          Color(0xffe3242b),
                          Color(0xff900d09),
                        ]),
                      ),
                      child: CupertinoButton(
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          onPressed: () {}),
                    )
                  : Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.02),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(colors: [
                            Color(0xffe3242b),
                            Color(0xff900d09),
                          ]),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black87,
                              blurRadius: 5.0,
                              offset: Offset(2, 2), // Shadow position
                            ),
                          ]),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
            );
          },
        ),
        title: Text(
          "Мэдээ",
          style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: MediaQuery.of(context).size.height * 0.026,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800]),
        ),
      ),
      backgroundColor: Color(0xffd0d3d5),
      body: Column(
        children: [
          // NewsAppBar(),

          _cardWidget(context),
        ],
      ),
    );
  }

  Widget _cardWidget(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
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
                                  fontSize: MediaQuery.of(context).size.height *
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
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.03,
              right: MediaQuery.of(context).size.height * 0.04,
              left: MediaQuery.of(context).size.height * 0.04,
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
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              color: Colors.amber,
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.04,
                right: MediaQuery.of(context).size.height * 0.04,
                top: MediaQuery.of(context).size.height * 0.31,
                bottom: MediaQuery.of(context).size.height * 0.04,
              ),
              // height: MediaQuery.of(context).size.height * 0.6,
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec id vulputate massa, id convallis nibh. Suspendisse eget lectus eu metus eleifend sagittis. Suspendisse eleifend vulputate sodales. Integer sit amet metus quis enim ornare tempus. Sed molestie quam et erat volutpat congue. Etiam a massa at odio vulputate interdum. Phasellus quis arcu sit amet mauris facilisis euismod in mollis sapien. Ut laoreet, nulla vitae iaculis rutrum, diam mauris malesuada orci, a scelerisque orci arcu non turpis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Fusce hendrerit lorem finibus ex auctor fermentum sed in eros. Praesent in rhoncus lectus. Etiam molestie ante quis eros accumsan porttitor. Cras at metus congue, sodales est eget, ultricies mauris. Etiam sit amet nunc ut ipsum rutrum molestie sed in ante. Nam et metus id mi dignissim tincidunt. Nullam in augue gravida, interdum quam a, bibendum est. Nunc ornare tellus sit amet facilisis ultrices. Interdum et malesuada fames ac ante ipsum primis in faucibus. Vivamus in pharetra risus. Praesent hendrerit, nisi et tempor ornare, ex metus lobortis tortor, nec eleifend nunc magna quis odio. Sed quis nisl cursus, sodales dui sit amet, dignissim augue. Morbi fringilla condimentum eros quis pretium. In dignissim, erat et auctor tempor, est tortor elementum arcu, id cursus justo erat id massa. Donec at faucibus urna. Ut consectetur neque risus, ac lobortis turpis maximus nec. Suspendisse maximus mauris felis. Nunc dictum sem quis nulla lacinia bibendum. Fusce sit amet lectus id libero ultrices dictum lacinia id neque.",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: MediaQuery.of(context).size.height * 0.018,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
