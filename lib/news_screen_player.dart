import 'package:carpro/model/news_item.dart';
import 'package:carpro/news_detail_screen.dart';
import 'package:carpro/widget/search_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'constants.dart';
import 'widget/appBar_title.dart';
import 'widget/arrow_button.dart';

class NewsScreenPlayer extends StatefulWidget {
  NewsScreenPlayer({this.url});
  final url;
  @override
  _NewsScreenPlayerState createState() => _NewsScreenPlayerState();
}

DateTime now = DateTime.now();

class _NewsScreenPlayerState extends State<NewsScreenPlayer> {
  // YoutubePlayerController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd0d3d5),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.05,
            bottom: MediaQuery.of(context).size.height * 0.02,
          ),
          child: Row(
            children: [
              ArrowButton(),
              AppBarTitle(title: "Мэдээ"),
              Expanded(
                child: SearchBtn(
                  searchText: "Хайлтын түлхүүр үг",
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          _listView(context),
        ],
      ),
    );
  }

  Widget _listView(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: ScrollController(),
        scrollDirection: Axis.vertical,
        itemCount: listItem.length,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.01,
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
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.26,
                        // maxWidth: MediaQuery.of(context).size.height * 0.3,
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                              top: MediaQuery.of(context).size.height * 0.18,
                              left: MediaQuery.of(context).size.height * 0.01,
                              right: MediaQuery.of(context).size.height * 0.01,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.005,
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    child:
                                        //  Icon(
                                        //   Icons.bookmark_border,
                                        //   size: MediaQuery.of(context).size.height * 0.03,
                                        // ),
                                        Image.asset(
                                      "assets/bookmark.png",
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                    ),
                                  ),
                                ]),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewsDetailScreen(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.01,
                                right:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              child: Text(
                                "Үргэлжлүүлэн унших",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.01,
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
              Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height,
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.045,
                      right: MediaQuery.of(context).size.height * 0.04,
                      left: MediaQuery.of(context).size.height * 0.04,
                    ),
                    height: MediaQuery.of(context).size.height * 0.16,
                    width: MediaQuery.of(context).size.width / 1,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        // child: Image(
                        //   image: AssetImage(
                        //     listItem[index]['video'].toString(),
                        //   ),
                        //   fit: BoxFit.fill,
                        // ),
                        child: YoutubePlayerBuilder(
                          player: YoutubePlayer(
                            controller: YoutubePlayerController(
                              initialVideoId: 'o2KveVr7adg',
                              flags: YoutubePlayerFlags(
                                hideControls: false,
                                controlsVisibleAtStart: true,
                                autoPlay: false,
                              ),
                            ),
                          ),
                          builder: (context, player) {
                            return Container(
                              child: player,
                            );
                          },
                        )),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
